# Temporary type piracy to fix issue with `Truth` in PairPlots
Base.keytype(::NamedTuple) = Symbol

# make sure we are using the version contained
# in whatever state the parent directory is;
# this is the intended behaviour both for CI and
# local development
using Pkg
script_dir = @__DIR__
Pkg.activate(script_dir)
parent_dir = dirname(script_dir)
Pkg.develop(PackageSpec(path=parent_dir))
doc_root = script_dir

using DynamicPPL
using BridgeStan
using Pigeons
using InferenceReport
using Documenter
using DocStringExtensions
import InferenceReport: as_doc_page, report_to_docs, headless

# Delete old generated pages
generated = "$script_dir/src/generated"
try 
    rm(generated, recursive=true)
catch 
end

# use this to draft faster during doc dev
skip_example = false

function run_examples() 
    if skip_example 
        return [] 
    else

        # Unidentifiable example / concentration on sub-manifold
        inputs, reproducibility_command = 
            @reproducible Inputs(;
                target = Pigeons.toy_turing_unid_target(), 
                n_rounds = 10, 
                record = [traces; round_trip; record_default()])
        unid = report_to_docs(
            pigeons(inputs);
            show_error_traces = true,
            reproducibility_command,
            doc_root)

        # Classic Neal's funnel example
        inputs, reproducibility_command = 
            @reproducible Inputs(;
                target = Pigeons.stan_funnel(2), 
                variational = GaussianReference(first_tuning_round = 5),
                n_rounds = 10, 
                record = [traces; round_trip; record_default()])
        funnel = report_to_docs(
            pigeons(inputs);
            reproducibility_command,
            doc_root)

        # Banana distribution example
        inputs, reproducibility_command = 
            @reproducible Inputs(;
                target = Pigeons.stan_banana(2), 
                variational = GaussianReference(first_tuning_round = 5),
                n_rounds = 10, 
                record = [traces; round_trip; record_default()])
        banana = report_to_docs(
            pigeons(inputs);
            reproducibility_command,
            doc_root)

        # 8 schools example (hard, non-reparameterized version)
        inputs, reproducibility_command = 
            @reproducible Inputs(;
                target = Pigeons.stan_eight_schools(), 
                variational = GaussianReference(first_tuning_round = 5),
                n_rounds = 10, 
                record = [traces; round_trip; record_default()])
        schools = report_to_docs(
            pigeons(inputs);
            reproducibility_command,
            doc_root)

        # Return links suitable for the navigation bar
        # i.e. passed into the `pages` argument of `makedocs`
        return [
            as_doc_page(unid),
            as_doc_page(funnel),
            as_doc_page(banana),
            as_doc_page(schools),
        ]

    end
end

# enclose the following in headless() to avoid useless render and 
# also to avoid the pages opening in the browser when drafting
headless() do
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
            "User guide" => "index.md",
            "Examples" => run_examples(),
            "Reference" => "reference.md",
        ],
    )
end

file_in_readme = "$doc_root/build/generated/toy_turing_unid_model/src/index.html"
if !skip_example && !isfile(file_in_readme)
    throw("missing file expected in README.md: $file_in_readme")
end

deploydocs(;
    repo="github.com/Julia-Tempering/InferenceReport.jl",
    devbranch="main",
)

# convenient to quickly open draft during doc dev
"$doc_root/build/index.html"
