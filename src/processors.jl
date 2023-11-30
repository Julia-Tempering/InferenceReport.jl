function pair_plot(context)
    plot = PairPlots.pairplot(context.chains) 
    file = output_file(context, "pair_plot", "svg")
    CairoMakie.save(file, plot)
    add_plot(context; 
        file = "pair_plot.svg", 
        title = "Pair plot", 
        movie = moving_pair_plot(context),
        description = """
            Diagonal entries show estimates of the marginal 
            densities as well as the (0.16, 0.5, 0.84) quantiles. 
            Off-diagonal entries whow estimates of the pairwise 
            densities. 

            Movie linked below (🍿) superimposes 
            $(moving_pair_plot_iters(context)) iterations 
            of MCMC.
            """)
end

moving_pair_plot_iters(context) = min(size(context.chains)[1], context.options.max_moving_plot_iters)
function moving_pair_plot(context)
    mcmc_chains = context.chains
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
    summary = context.pt.shared.reports.summary
    add_table(context; 
        table = summary, 
        title = "Pigeons summary")
end

function moments(context)
    summary = summarize(context.chains) 
    add_table(context; 
        table = summary, 
        title = "Moments")
end

trace_plot_cumulative(context) = trace_plot(context, true)
trace_plot(context) = trace_plot(context, false)
function trace_plot(context, cumulative)

    # from MCMCChains doc: 
    chns = context.chains
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
    dict = as_dict(context.pt.inputs) 
    dict[:exec_folder] = string(pt.exec_folder)
    add_table(context; 
        table = dict,
        title = "Pigeons inputs", 
        alignment = [:r, :l])
end



