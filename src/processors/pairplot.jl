struct PairPlotPostprocessor end 
function postprocess(::PairPlotPostprocessor, context)
    plot = PairPlots.pairplot(context.chains) 
    file = output_file(context, "pair_plot", "svg")
    CairoMakie.save(file, plot)
    add_plot(context; 
        file = "pair_plot.svg", 
        title = "Pair plot")
end