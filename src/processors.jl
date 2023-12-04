target_title(context) = 
    add_top_title(context; 
        title = `$(target_name(context))`)

function pair_plot(context)
    plot = PairPlots.pairplot(get_chains(context)) 
    file = output_file(context, "pair_plot", "svg")
    CairoMakie.save(file, plot)
    add_plot(context; 
        file = "pair_plot.svg", 
        title = "Pair plot", 
        movie = moving_pair_plot(context),
        description = """
            Diagonal entries show estimates of the marginal 
            densities as well as the (0.16, 0.5, 0.84) 
            quantiles (dotted lines). 
            Off-diagonal entries show estimates of the pairwise 
            densities. 

            Movie linked below (🍿) superimposes 
            $(moving_pair_plot_iters(context)) iterations 
            of MCMC. 
            """)
end

moving_pair_plot_iters(context) = min(size(get_chains(context))[1], context.options.max_moving_plot_iters)
function moving_pair_plot(context)
    mcmc_chains = get_chains(context)
    n = filter(x -> x != :log_density, names(mcmc_chains)) 
    fig = Figure(size=(800,800))
    framerate = 10
    iters = range(1, moving_pair_plot_iters(context))
    file_output = "moving_pair.mp4"
    record(fig, "$(context.output_directory)/$file_output", iters; framerate) do t
        empty!(fig)
        pairplot(fig[1,1], mcmc_chains, 
            current_position(mcmc_chains, n, t, 1) 
        )
    end
    return file_output
end

function pigeons_summary(context)
    summary = get_pt(context).shared.reports.summary
    add_table(context; 
        table = summary, 
        title = "Pigeons summary")
end

function moments(context)
    summary = summarize(get_chains(context)) 
    add_table(context; 
        table = summary, 
        title = "Moments")
end

trace_plot_cumulative(context) = trace_plot(context, true)
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
    file = output_file(context, name, "svg")
    CairoMakie.save(file, fig, size= (800, 200 * n_params))
    add_plot(context; 
        file = "$name.svg", 
        title = cumulative ? "Cumulative traces" : "Trace plots")
end

function pigeons_inputs(context) 
    dict = as_dict(get_pt(context).inputs) 
    dict[:exec_folder] = string(pt.exec_folder)
    add_table(context; 
        table = dict,
        title = "Pigeons inputs", 
        alignment = [:r, :l])
end

function reproducibility_info(context)
    if isnothing(context.options.reproducibility_command)
        bail("missing reproducibility_command")
    end
    cmd = reproducibility_command(context, context.posterior.algorithm)
    add_markdown(context; 
        title = "Reproducibility",
        contents = """
        ```
        $cmd
        ```
        """
    )
end

function mpi_standard_out(context) 
    pt = get_pt(context)
    output_folder = "$(pt.exec_folder)/1"
    machine = 1
    output_file_name = Pigeons.find_rank_file(output_folder, machine)
    stdout_file = "$output_folder/$output_file_name/stdout"
    if !isfile(stdout_file)
        bail("no standard out file found (only on MPI at moment)")
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

logz_progress(context) = 
    pigeons_progress(context; 
        property = :stepping_stone, 
        title = "Evidence estimation progress",
        description = """
            Estimate of the log normalization (computed using 
            the stepping stone estimator) as a function of 
            the adaptation round. 
            """)

gcb_progress(context) = 
    pigeons_progress(context; 
        property = :global_barrier, 
        title = "GCB estimation progress",
        description = """
            Estimate of the Global Communication Barrier (GCB) 
            as a function of 
            the adaptation round. 
            """)

function round_trip_progress(context) 
    pt = get_pt(context)
    if !(Pigeons.round_trip in pt.inputs.record) 
        bail("number restarts not recorded")
    end
    pigeons_progress(context; 
        property = :n_tempered_restarts, 
        title = "Round trips",
        description = """
            Number of tempered restarts  
            as a function of 
            the adaptation round. 
            """)     
end       

function pigeons_progress(context; property, title, description)
    pt = get_pt(context)
    recipe = 
        data(pt.shared.reports.summary) * 
        mapping(:round, property) * 
        visual(Lines)
    plot = draw(recipe)
    file = output_file(context, "$(property)_progress", "svg")
    CairoMakie.save(file, plot)
    add_plot(context; 
        file = "$(property)_progress.svg", 
        title, 
        description)
end
