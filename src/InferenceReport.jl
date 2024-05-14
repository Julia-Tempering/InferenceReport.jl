module InferenceReport

using CairoMakie
CairoMakie.activate!(type = "png", px_per_unit = 2)

using Documenter
using MCMCChains
using PairPlots
using Pigeons
using PrettyTables 
using MCMCChains 
using CSV
using Serialization
using AlgebraOfGraphics
using DocStringExtensions
using JSON
using Logging
import Pigeons: @auto
using DataFrames
using DocumenterCitations

include("TargetDescription.jl")
include("ReportOptions.jl")
include("Inference.jl")
include("PostprocessContext.jl") 

"""
$SIGNATURES
"""
default_postprocessors() = [
    target_description,
    pair_plot,
    trace_plot, 
    moments,
    trace_plot_cumulative,    
    mpi_standard_out,
    lcb,
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
    inference = Inference(algo_or_chains, options.max_dim)

    src_dir = mkpath("$(options.exec_folder)/src")
    context = PostprocessContext(inference, src_dir, String[], Dict{String,Any}(), options)
    add_key_value(context, "target_name", target_name(options.target_name, algo_or_chains))
    add_key_value(context, "original_dim", inference.original_dim)
    warn_if_truncated(context)

    for postprocessor in options.postprocessors 
        print("$postprocessor...")
        try
            postprocessor(context)
            println(" ✓")
        catch e 
            println("[skipped: $e]")
            if options.show_error_traces 
                @error "Details:" exception=(e, catch_backtrace())
            end
        end
    end

    write(output_file(context, "info", "json"), JSON.json(context.generated_dict, 4))
    write(output_file(context, "index", "md"), join(context.generated_markdown, "\n"))
    if options.render
        render(context)
        if options.view 
            view_webpage(options.exec_folder)
        end
    end 
    println("Report generated at: $(options.exec_folder)")
    return context
end

"""
$SIGNATURES 

Similar to [`report`](@ref) but with different defaults to 
facilitate including the 
result as part of a larger documentation site. 

Use in combination with [`as_doc_page`](@ref).
"""
function report_to_docs(algo_or_chains; doc_root::String, args...)
    # results has to be placed in docs/src 
    # and for some mysterious reason, the standard results/all/xyz/ does not 
    # work (too deep of a hierarchy?)
    @assert basename(doc_root) == "docs"
    generated_dir = "$doc_root/src/generated"

    name = target_name(ReportOptions(; args...).target_name, algo_or_chains)
    dest = "$generated_dir/$name"
    mkpath(dest)
    report(algo_or_chains; 
        render = false, 
        exec_folder = dest, 
        args...)
end

"""
$SIGNATURES

Pass to the `pages` argument of 
[`makedocs`](https://documenter.juliadocs.org/stable/lib/public/#Documenter.makedocs) 
to properly include the generated page in the Documenter.jl navigation bar. 
"""
as_doc_page(context) = "`$(target_name(context))`" => "generated/$(basename(dirname(context.output_directory)))/src/index.md"

"""
$SIGNATURES 
"""
function view_webpage(exec_folder)
    # Try to autodect if we built HTML or a PDF
    if isfile("$exec_folder/build/InferenceReport.pdf")
        open_in_default_browser("$exec_folder/build/InferenceReport.pdf")
    else
        open_in_default_browser("$exec_folder/build/index.html")
    end
end
"""
$SIGNATURES 
"""
function render(context) 
    pages = ["`$(target_name(context))`" => "index.md"]
    add_bib(context, pages)
    makedocs(;
        root = dirname(context.output_directory),
        sitename = "InferenceReport",
        repo="https://github.com/Julia-Tempering/InferenceReport.jl/blob/{commit}{path}#{line}",
        format = context.options.writer,
        pages, 
        plugins = make_doc_plugins(get_bib(context))
    )
end

# Controls defaults such as whether to render and open webpage right away
# Julia's isinteractive not good enough: returns true even inside Documenter.jl rendering pipeline
const isinteractive = Ref{Bool}(true)

""" 
$SIGNATURES 

Enclose calls to [`report_to_docs`](@ref) and [`report`](@ref) 
with different defaults for the `view` and `render` options, 
setting them to false by default.
"""
function headless(lambda)
    previous = isinteractive[]
    isinteractive[] = false 
    try 
        lambda() 
    finally
        isinteractive[] = previous
    end
end

"""
$SIGNATURES 

Returns a pair, where the first argument is 
the provided expression verbatim, and the second, 
the expression as a string to be used as the 
`reproducibility_command` argument in [`report`](@ref) 
and [`report_to_docs`](@ref).
"""
macro reproducible(lambda::Expr)
    str = string(lambda)
    return :($(esc(lambda)), $str)
end

include("building_blocks.jl")
include("utils.jl")
include("processors.jl")
include("make_index.jl")

export report, @reproducible, cite!, TargetDescription

end # module
