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
import InferenceReport: report_to_docs


DocMeta.setdocmeta!(InferenceReport, :DocTestSetup, :(using InferenceReport); recursive=true)

generated = "$script_dir/src/generated"
try 
    rm(generated, recursive=true)
catch 
end

n_rounds = 10
unid = report_to_docs(
        pigeons(;
            target = Pigeons.toy_turing_unid_target(), 
            n_rounds, 
            record = [traces; round_trip; record_default()]); 
        doc_root = script_dir)

funnel = report_to_docs(
    pigeons(;
        target = Pigeons.stan_funnel(2), 
        n_rounds, 
        record = [traces; round_trip; record_default()]); 
    doc_root = script_dir)

banana = report_to_docs(
    pigeons(;
        target = Pigeons.stan_banana(2), 
        n_rounds, 
        record = [traces; round_trip; record_default()]); 
    doc_root = script_dir)

schools = report_to_docs(
    pigeons(;
        target = Pigeons.stan_eight_schools(), 
        n_rounds, 
        record = [traces; round_trip; record_default()]); 
    doc_root = script_dir)

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
        "Examples" => [
            "Submanifold" => unid,
            "Funnel" => funnel,
            "Banana" => banana,
            "8 schools" => schools
        ],
        "Reference" => "reference.md",
    ],
)

try
    rm(joinpath(script_dir, "build", "results"), recursive=true) # delete `results` folder before deploying
catch 
end

deploydocs(;
    repo="github.com/Julia-Tempering/InferenceReport.jl",
    devbranch="main",
)
