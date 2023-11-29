struct TracePlotsPostprocessor end 
function postprocess(::TracePlotsPostprocessor, context)

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
            values = chns[:, param, chain]
            lines!(ax, 1:n_samples, values; label=string(chain))
        end

        hideydecorations!(ax; label=false)
        if i < length(params)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Iteration"
        end
    end
    resize_to_layout!(fig)

    file = output_file(context, "trace_plot", "svg")
    CairoMakie.save(file, fig, size= (800, 200 * n_params))
    add_plot(context; 
        file = "trace_plot.svg", 
        title = "Trace plots")
end