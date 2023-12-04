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
    target_name::Union{String, Nothing} = nothing
    view::Bool = true 
    postprocessors::Vector = default_postprocessors()
    exec_folder::String = Pigeons.next_exec_folder()
    reproducibility_command::Union{String, Nothing} = nothing
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

target_name(context::PostprocessContext) = target_name(context.options.target_name, context.posterior.algorithm) 
target_name(unspecified_name::Nothing, pt::PT) = pigeons_target_name(pt.inputs.target)
pigeons_target_name(target::TuringLogPotential) = string(target.model.f)
pigeons_target_name(target) = string(target)

target_name(unspecified_name::Nothing, _) = "UntitledPosterior" 
target_name(specified_name::String, _) = specified_name 

get_pt(context::PostprocessContext) = get_pt(context.posterior.algorithm) 
get_pt(unknown_algo) = bail("only applies to Pigeons")
get_pt(pt::PT) = pt

get_chains(context) = context.posterior.chains

default_postprocessors() = [
    target_title,
    pair_plot,
    trace_plot, 
    moments,
    trace_plot_cumulative,    
    mpi_standard_out,
    gcb_progress,
    logz_progress,
    round_trip_progress,
    pigeons_summary,
    pigeons_inputs,
    reproducibility_info,
]

report(algo_or_chains; args...) = report(algo_or_chains, ReportOptions(; args...))
function report(algo_or_chains, options::ReportOptions) 
    posterior = Posterior(algo_or_chains)

    src_dir = mkpath("$(options.exec_folder)/src")
    context = PostprocessContext(posterior, src_dir, [], options)

    for postprocessor in options.postprocessors 
        print("$postprocessor...")
        try
            postprocessor(context)
            println(" ✓")
        catch e 
            println("[skipped: $e]")
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
        pages = ["`$(target_name(context))`" => "posterior.md"])


include("building_blocks.jl")
include("utils.jl")
include("processors.jl")


inputs = include("../script.jl")
pt = pigeons(inputs)

#report(Chains(pt))

report(pt, reproducibility_command = """include("script.jl")""")