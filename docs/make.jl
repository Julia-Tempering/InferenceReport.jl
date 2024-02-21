# make sure we are using the version contained
# in whatever state the parent directory is;
# this is the intended behaviour both for CI and
# local development
using Pkg
script_dir = @__DIR__
Pkg.activate(script_dir)
parent_dir = dirname(script_dir)
Pkg.develop(PackageSpec(path=parent_dir))

using DynamicPPL
using BridgeStan
using Pigeons
using InferenceReport
using Documenter
using DocStringExtensions
using Plots

# based on: https://github.com/JuliaPlots/PlotlyJS.jl/blob/master/docs/make.jl
using PlotlyJS
using PlotlyBase
PlotlyJS.set_default_renderer(PlotlyJS.DOCS)

DocMeta.setdocmeta!(InferenceReport, :DocTestSetup, :(using InferenceReport); recursive=true)

makedocs(;
    modules=[InferenceReport],
    authors="Miguel Biron-Lattes <miguel.biron@stat.ubc.ca>, Alexandre Bouchard-Côté <alexandre.bouchard@gmail.com>, Trevor Campbell <trevor@stat.ubc.ca>, Nikola Surjanovic <nikola.surjanovic@stat.ubc.ca>, Saifuddin Syed <saifuddin.syed@stats.ox.ac.uk>, Paul Tiede <ptiede91@gmail.com>",
    repo="https://github.com/Julia-Tempering/InferenceReport.jl/blob/{commit}{path}#{line}",
    sitename="InferenceReport.jl",
    # strict=true, # deprecated in v1.0.0. now it is the default. see https://github.com/JuliaDocs/Documenter.jl/blob/77f0bdd7c742fc7d7ed91c6b0ab6582f14e33e81/CHANGELOG.md?plain=1#L51
    format=Documenter.HTML(;
        prettyurls=true, # always on, avoids confusion when building locally. If needed, serve the "build" folder locally with LiveServer. #get(ENV, "CI", "false") == "true",
        canonical="https://Julia-Tempering.github.io/InferenceReport.jl",
        edit_link="main",
        assets=String[],
        size_threshold = nothing # overrides default size limit for a single html file
    ),
    pages=[
        "Usage" => "index.md",
    ],
)

rm(joinpath(script_dir, "build", "results"), recursive=true) # delete `results` folder before deploying

deploydocs(;
    repo="github.com/Julia-Tempering/InferenceReport.jl",
    devbranch="main",
)
