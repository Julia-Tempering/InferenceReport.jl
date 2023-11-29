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

import Pigeons: @auto

include("PostprocessorContext.jl")

## API for users

default_postprocessors() = [
    PairPlotPostprocessor(),
    TracePlotsPostprocessor(),   
    MCMCChainsPostprocessor(),
]

# TODO: add global options for e.g. file types

function postprocess(postprocessor, context) end

function postprocess(
        pt::PT;
        postprocessors = default_postprocessors(), 
        output_directory::String = Pigeons.next_exec_folder()) 
    src_dir = "$output_directory/src"
    mkpath(src_dir)
    context = PostprocessContext(pt, src_dir, Chains(pt), [])
    for postprocessor in postprocessors 
        postprocess(postprocessor, context)
    end
    write(output_file(context, "posterior", "md"), join(context.generated_markdown, "\n"))
    return context
end

include("building_blocks.jl")

include("processors/summary.jl")
include("processors/pairplot.jl")
include("processors/traceplots.jl")

pt = pigeons(target = toy_mvn_target(5), record = [traces])

context = postprocess(pt)

makedocs(;
    root = dirname(context.output_directory),
    sitename = "PosteriorDocumenter",
    repo="https://github.com/Julia-Tempering/Pigeons.jl/blob/{commit}{path}#{line}",
    format = Documenter.HTML(),
    pages = ["Posterior" => "posterior.md"])


run(`open $(dirname(context.output_directory))/build/posterior/index.html`)