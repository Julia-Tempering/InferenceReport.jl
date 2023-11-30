using Pkg 
Pkg.activate(".")

using CairoMakie
using Documenter
using MCMCChains
using PairPlots
using Pigeons
using Plots
using StatsPlots
using PrettyTables 
using MCMCChains 
using CSV
using Serialization

# TODO remove StanBridge, DynamicPPL from deps!

import Pigeons: @auto

@kwdef struct ReportOptions 
    max_moving_plot_iters::Int = 100
end

@auto struct PostprocessContext 
    pt
    output_directory 
    chains
    generated_markdown
    options
end

## API for users

default_postprocessors() = [
    pair_plot,
    trace_plot,   
    trace_plot_cumulative,  
    moments,
    pigeons_summary,
    pigeons_inputs,
]

function report(
            pt::PT;
            view = true,
            target_name = string(pt.inputs.target),
            save_reproducibility_info = true,
            postprocessors = default_postprocessors(), 
            exec_folder::String = Pigeons.next_exec_folder(),
            options = ReportOptions()) 
    src_dir = mkpath("$exec_folder/src")
    context = PostprocessContext(pt, src_dir, Chains(pt), [], options)
    add_top_title(context; title = target_name)
    for postprocessor in postprocessors 
        print("$postprocessor...")
        postprocessor(context)
        println(" ✓")
    end
    write(output_file(context, "posterior", "md"), join(context.generated_markdown, "\n"))
    render(context)
    if view 
        view_webpage(exec_folder)
    end
    if save_reproducibility_info 
        serialize("$exec_folder/Inputs.jls", pt.inputs)
    end
    return exec_folder
end

view_webpage(exec_folder) = open_in_default_browser("$exec_folder/build/posterior/index.html")

render(context) = 
    makedocs(;
        root = dirname(context.output_directory),
        sitename = "PosteriorDocumenter",
        repo="https://github.com/Julia-Tempering/Pigeons.jl/blob/{commit}{path}#{line}",
        format = Documenter.HTML(),
        pages = ["Posterior" => "posterior.md"])


include("building_blocks.jl")
include("utils.jl")
include("processors.jl")


pt = pigeons(target = toy_mvn_target(3), 
    record = [traces; record_default()])
report(pt)