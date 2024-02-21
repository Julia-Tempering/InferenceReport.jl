module InferenceReport

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
using AlgebraOfGraphics
using DocStringExtensions


import Pigeons: @auto

"""
Options to control [`report`](@ref):

$FIELDS
"""
@kwdef struct ReportOptions 
    """
    Maximum number of iterations in [`moving_pair_plot`](@ref).
    """
    max_moving_plot_iters::Int = 100

    """
    Name of the target. If nothing, [`target_name`](@ref) will 
    be used to attempt to auto-detect it.
    """
    target_name::Union{String, Nothing} = nothing

    """
    If true, the report webpage's md files are rendered into html files.
    """
    render::Bool = true 

    """
    If true, the report webpage will be opened automatically.
    """
    view::Bool = true 

    """
    The postprocessors to use. 
    Default is [`default_postprocessors`](@ref). 
    """
    postprocessors::Vector = default_postprocessors()

    """ 
    The directory where the report will be created. 
    A unique folder in `results/all` will be created by 
    default and symlinked in `results/latest`.
    """
    exec_folder::String = Pigeons.next_exec_folder()

    """
    A command to instruct users how to reproduce. 

    At the moment implicitly assumes Pigeons will be used, 
    and running these commands should return 
    the [Inputs](https://pigeons.run/dev/reference/#Pigeons.Inputs). 
    """
    reproducibility_command::Union{String, Nothing} = nothing
end

"""
The object of a report created by this package:

$FIELDS
"""
@auto struct Inference 
    """ 
    Detailed algorithm that created the samples (currently assumes 
    it is a [`PT`](https://pigeons.run/dev/reference/#Pigeons.PT) struct).
    Optional, nothing if unspecfied.
    """
    algorithm 

    """
    Samples, stored in a [`Chains`](https://turinglang.org/MCMCChains.jl/stable/chains/) 
    struct. 
    """
    chains 
end

# TODO: constant-memory variants?
Inference(result::Result{PT}) = Inference(load(result))
Inference(algorithm) = Inference(algorithm, Chains(algorithm))
Inference(chains::Chains) = Inference(nothing, chains)

"""
Information passed to the processors:

$FIELDS
"""
@auto struct PostprocessContext 
    """
    The [`Inference`](@ref) on which the report will be based on.
    """
    inference

    """
    The resolved location of the output report.  
    """
    output_directory::String

    """
    Vector of Strings used internally. 
    """
    generated_markdown

    """
    The [`ReportOptions`](@ref). 
    """
    options
end

Base.show(io::IO, c::PostprocessContext) = "PostprocessContext(output_directory = $(c.output_directory))"

"""
$SIGNATURES 
"""
target_name(context::PostprocessContext) = target_name(context.options.target_name, context.inference.algorithm) 

"""
$SIGNATURES 
"""
target_name(unspecified_name::Nothing, pt::PT) = pigeons_target_name(pt.inputs.target)

"""
$SIGNATURES 
"""
target_name(unspecified_name::Nothing, _) = "UntitledInference" 

"""
$SIGNATURES 
"""
target_name(specified_name::String, _) = specified_name 

"""
$SIGNATURES 
"""
pigeons_target_name(target::TuringLogPotential) = string(target.model.f)

"""
$SIGNATURES 
"""
pigeons_target_name(target) = string(target)

get_pt(context::PostprocessContext) = get_pt(context.inference.algorithm) 
get_pt(unknown_algo) = throw("only applies to Pigeons")
get_pt(pt::PT) = pt

get_chains(context) = context.inference.chains

"""
$SIGNATURES
"""
default_postprocessors() = [
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
    reproducibility_info
]

"""
$SIGNATURES 

`algo_or_chains` can be either a [`PT`](https://pigeons.run/dev/reference/#Pigeons.PT) struct 
(returned by [`pigeons(..)`](https://pigeons.run/dev/#Basic-usage)) or 
a [`Chains`](https://turinglang.org/MCMCChains.jl/stable/chains/).

`args` are used to create a [`ReportOptions`](@ref). 
"""
report(algo_or_chains; args...) = report(algo_or_chains, ReportOptions(; args...))

"""
$SIGNATURES
"""
function report(algo_or_chains, options::ReportOptions) 
    inference = Inference(algo_or_chains)

    src_dir = mkpath("$(options.exec_folder)/src")
    context = PostprocessContext(inference, src_dir, String[], options)

    for postprocessor in options.postprocessors 
        print("$postprocessor...")
        try
            postprocessor(context)
            println(" ✓")
        catch e 
            println("[skipped: $e]")
        end
    end

    write(output_file(context, "inference", "md"), join(context.generated_markdown, "\n"))
    if options.render
        render(context)
        if options.view 
            view_webpage(options.exec_folder)
        end
    end 
    return context
end

"""
$SIGNATURES 

Similar to [`report`](@ref) but as part of a larger documentation site. 

Returns the correct relative path to the `.md` file to be passed to 
the `pages` argument of [`makedocs`](https://documenter.juliadocs.org/stable/lib/public/#Documenter.makedocs).
"""
function report_to_docs(algo_or_chains; doc_root::String, args...)
    @assert basename(doc_root) == "docs"
    
    context = report(algo_or_chains; 
        render = false, 
        exec_folder = tempdir(), 
        args...)

    name = target_name(context) 
    output = context.output_directory
    id = basename(dirname(output))

    dest = "$doc_root/src/generated"
    mkpath(dest)

    mv("$output", "$dest/$name-$id")

    return "generated/$name-$id/inference.md"
end

view_webpage(exec_folder) = open_in_default_browser("$exec_folder/build/inference/index.html")

render(context) = 
    makedocs(;
        root = dirname(context.output_directory),
        sitename = "InferenceReport",
        repo="https://github.com/Julia-Tempering/Pigeons.jl/blob/{commit}{path}#{line}",
        format = Documenter.HTML(),
        pages = ["`$(target_name(context))`" => "inference.md"])


include("building_blocks.jl")
include("utils.jl")
include("processors.jl")

export  report

end # module
