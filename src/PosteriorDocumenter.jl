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
    target_name::String = "" 
    view::Bool = true 
    postprocessors::Vector = default_postprocessors()
    exec_folder::String = Pigeons.next_exec_folder()
end

@auto struct Posterior 
    algorithm 
    chains 
end
# TODO: constant-memory variants?
Posterior(algorithm) = Posterior(algorithm, Chains(algorithm))
Posterior(chains::Chains) = Posterior(nothing, chains)

@auto struct PostprocessContext 
    posterior
    output_directory 
    generated_markdown
    options
end

get_pt(context::PostprocessContext) = get_pt(context.posterior.algorithm) 
get_pt(unknown_algo) = error("only applies to Pigeons")
get_pt(pt::PT) = pt

get_chains(context) = context.posterior.chains

## API for users

default_postprocessors() = [
    target_title,
    # pair_plot,
    # trace_plot,   
    trace_plot_cumulative,  
    moments,
    pigeons_summary,
    pigeons_inputs,
]

report(data; args...) = report(data, ReportOptions(args...))
function report(data, options::ReportOptions) 
    post = Posterior(data)

    src_dir = mkpath("$(options.exec_folder)/src")
    context = PostprocessContext(post, src_dir, [], options)

    for postprocessor in options.postprocessors 
        print("$postprocessor...")
        try
            postprocessor(context)
            println(" ✓")
        catch e 
            println("[skipped: $(e.msg)]")
        end
    end

    write(output_file(context, "posterior", "md"), join(context.generated_markdown, "\n"))
    render(context)
    if options.view 
        view_webpage(options.exec_folder)
    end

    return options.exec_folder
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
    n_rounds = 4,
    record = [traces; record_default()])

report(Chains(pt))

report(pt)