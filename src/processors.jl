"""
$SIGNATURES

Create a pair plot using [PairPlot.jl](https://github.com/sefffal/PairPlots.jl).
"""
function pair_plot(context)
    plot = PairPlots.pairplot(get_chains(context)) 
    file = output_file(context, "pair_plot", "png")
    CairoMakie.save(file, plot, px_per_unit=2)

    description = """
    Diagonal entries show estimates of the marginal 
    densities as well as the (0.16, 0.5, 0.84) 
    quantiles (dotted lines). 
    Off-diagonal entries show estimates of the pairwise 
    densities. 
    """
    if moving_pair_plot_iters(context) > 0 
        description *= """

        Movie linked below (🍿) superimposes 
        $(moving_pair_plot_iters(context)) iterations 
        of MCMC. 
        """
    end

    add_plot(context; 
        file = "pair_plot.png", 
        title = "Pair plot", 
        url_help = "https://sefffal.github.io/PairPlots.jl",
        movie = moving_pair_plot(context),
        description)
end

moving_pair_plot_iters(context) = min(size(get_chains(context))[1], context.options.max_moving_plot_iters)

"""
$SIGNATURES 

A PairPlot movie showing the sample in the reference chain moving in the state space. 
"""
function moving_pair_plot(context)
    n_iters = moving_pair_plot_iters(context)
    if n_iters == 0 
        return nothing 
    end
    mcmc_chains = get_chains(context)
    n = filter(x -> x != :log_density, names(mcmc_chains)) 
    fig = Figure(size=(800,800))
    framerate = 10
    iters = range(1, n_iters)
    file_output = "moving_pair.mp4"
    record(fig, "$(context.output_directory)/$file_output", iters; framerate) do t
        empty!(fig)
        pairplot(fig[1,1], mcmc_chains, 
            current_position(mcmc_chains, n, t, 1) 
        )
    end
    return file_output
end

"""
$SIGNATURES 

The summary table produced by Pigeons during its execution. 
"""
function pigeons_summary(context)
    summary = get_pt(context).shared.reports.summary
    add_table(context; 
        table = summary, 
        url_help = "https://pigeons.run/dev/output-reports/",
        title = "Pigeons summary")
end

"""
$SIGNATURES 

Table of means and variances. 
"""
function moments(context)
    summary = summarize(get_chains(context)) 
    add_table(context; 
        table = summary, 
        title = "Moments")
end

"""
$SIGNATURES 

Cumulative averages as a function of iteration. 
"""
trace_plot_cumulative(context) = trace_plot(context, true)

"""
$SIGNATURES

Trace plots. 
"""
trace_plot(context) = trace_plot(context, false)
function trace_plot(context, cumulative)

    # from MCMCChains doc: 
    chns = get_chains(context)
    params = names(chns, :parameters)

    n_chains = length(chains(chns))
    n_samples = length(chns)
    n_params = length(params)

    fig = Figure(;)

    for (i, param) in enumerate(params)
        ax = Axis(fig[i, 1]; ylabel=string(param))
        for chain in 1:n_chains
            cur_trace = chns[:, param, chain]
            values = cumulative ? cumsum(cur_trace) ./ collect(1:length(cur_trace)) : cur_trace
            lines!(ax, 1:n_samples, values; label=string(chain))
        end

        #hideydecorations!(ax; label=false)
        if i < length(params)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Iteration"
        end
    end
    resize_to_layout!(fig)

    name = cumulative ? "cumulative_trace_plot" : "trace_plot"
    file = output_file(context, name, "png")
    CairoMakie.save(file, fig, size= (800, 200 * n_params), px_per_unit=2)
    add_plot(context; 
        file = "$name.png", 
        title = cumulative ? "Cumulative traces" : "Trace plots",
        description = cumulative ? """
            For each iteration ``i``, shows the running average up to ``i``,
            ``\\frac{1}{i} \\sum_{n = 1}^{i} x_n``. 
            """ : "")
end

"""
$SIGNATURES 

Table of inputs used in Pigeons. 
"""
function pigeons_inputs(context) 
    pt = get_pt(context)
    dict = as_dict(pt.inputs) 
    dict[:exec_folder] = string(pt.exec_folder)
    add_table(context; 
        table = dict,
        title = "Pigeons inputs", 
        url_help = "https://pigeons.run/dev/reference/#Pigeons.Inputs",
        alignment = [:r, :l])
end

"""
$SIGNATURES 

Generated reproducibility script. 
"""
function reproducibility_info(context)
    if isnothing(context.options.reproducibility_command)
        throw("missing reproducibility_command")
    end
    cmd = reproducibility_command(context, context.inference.algorithm)
    add_key_value(context, "reproducibility_command", cmd)
    add_markdown(context; 
        title = "Reproducibility",
        contents = """
        ```
        $cmd
        ```
        """
    )
end

"""
$SIGNATURES 

MPI standard output. 
"""
function mpi_standard_out(context) 
    pt = get_pt(context)
    output_folder = "$(pt.exec_folder)/1"
    if !isfile(output_folder)
        throw("no MPI std out files found")
    end
    machine = 1
    output_file_name = Pigeons.find_rank_file(output_folder, machine)
    stdout_file = "$output_folder/$output_file_name/stdout"
    if !isfile(stdout_file)
        throw("no standard out file found (only on MPI at moment)")
    end
    stdout = read(stdout_file)
    add_markdown(context; 
        title = "Standard out",
        contents = """
        ```
        $stdout
        ```
        """
    )
end

"""
$SIGNATURES 

Progression of the log-normalization constant estimate as 
a function of the round. 
"""
function logz_progress(context) 
    final_val = Pigeons.stepping_stone(get_pt(context))
    add_key_value(context, "logz", final_val)
    pigeons_progress(context; 
        property = :stepping_stone, 
        title = "Evidence estimation progress",
        url_help = "https://pigeons.run/dev/output-normalization/",
        description = """
            Estimate of the log normalization (computed using 
            the stepping stone estimator) as a function of 
            the adaptation round. 

            Last round estimate: ``$final_val``
            """)
end

"""
$SIGNATURES 

Progression of the global communication barrier estimate as 
a function of the round. 
"""
function gcb_progress(context) 
    final_val = Pigeons.global_barrier(get_pt(context))
    add_key_value(context, "gcb", final_val)
    pigeons_progress(context; 
        property = :global_barrier, 
        title = "GCB estimation progress",
        url_help = "https://pigeons.run/dev/output-pt/#Global-communication-barrier",
        description = """
            Estimate of the Global Communication Barrier (GCB) 
            as a function of 
            the adaptation round. 

            The global communication barrier can be used 
            to set the number of chains. 
            The theoretical framework of [Syed et al., 2021](https://academic.oup.com/jrsssb/article/84/2/321/7056147)
            yields that under simplifying assumptions, it is optimal to set the number of chains 
            (the argument `n_chains` in `pigeons()`) to roughly 2Λ.

            Last round estimate: ``$final_val``
            """)
end

""" 
$SIGNATURES 

The local communication barrier estimated in the last round. 
"""
function lcb(context)
    barrier = get_pt(context).shared.tempering.communication_barriers.localbarrier
    xs = range(0.0, 1.0, length=100)
    ys = barrier.(xs)
    f = Figure()
    ax = Axis(f[1, 1])
    lines!(xs, ys)
    ax.xlabel = "β"
    ax.ylabel = "λ(β)"
    name = "local_barrier"
    file = output_file(context, name, "png")
    CairoMakie.save(file, f, px_per_unit=2)
    add_plot(context; 
        file = "$name.png", 
        title = "Local communication barrier", 
        url_help = "https://pigeons.run/dev/output-pt/#Local-communication-barrier",
        description = """
        When the global communication barrier is large, many chains may 
        be required to obtain tempered restarts.

        The local communication barrier can be used to visualize the cause 
        of a high global communication barrier. For example, if there is a 
        sharp peak close to a reference constructed from the prior, it may 
        be useful to switch to a [variational approximation](https://pigeons.run/dev/variational/#variational-pt).
        """)
end

"""
$SIGNATURES 

Progression of the number of round trips as 
a function of the round. 
"""
function round_trip_progress(context) 
    pt = get_pt(context)
    if !(Pigeons.round_trip in pt.inputs.record) 
        throw("number restarts not recorded")
    end
    pigeons_progress(context; 
        property = :n_tempered_restarts, 
        title = "Round trips",
        url_help = "https://pigeons.run/dev/output-pt/#Round-trips-and-tempered-restarts",
        description = """
            Number of tempered restarts  
            as a function of 
            the adaptation round. 

            A tempered restart happens when a sample from the 
            reference percolates to the target. When the reference 
            supports iid sampling, tempered restarts can enable 
            large jumps in the state space.
            """)     
end       

function pigeons_progress(context; property, title, args...)
    pt = get_pt(context)
    recipe = 
        data(pt.shared.reports.summary) * 
        mapping(:round, property) * 
        visual(Lines)
    plot = draw(recipe)
    file = output_file(context, "$(property)_progress", "png")
    CairoMakie.save(file, plot)
    add_plot(context; 
        file = "$(property)_progress.png", 
        title, 
        args...)
end
"""
$SIGNATURES
A plot showing progression of mean swap acceptance per chain as a function of round.
"""
function swaps_plot(context)
    swaps = get_pt(context).shared.reports.swap_prs
    swaps[!,"first"] = string.(swaps[!,"first"])

    fig = Figure()
    plt = data(swaps) * mapping(:round => "Round", :mean => "Mean", marker = :first, color = :first) * visual(AlgebraOfGraphics.ScatterLines)
    
    draw!(fig, plt, axis=(title="Swap Acceptance Rates per Chain",))

    file = output_file(context, "swaps_plot", "png")
    CairoMakie.save(file, fig, px_per_unit = 2)
    

    add_plot(context;
    file = "swaps_plot.png",
    title = "Swaps plot")
end