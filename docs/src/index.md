```@meta
CurrentModule = InferenceReport
```

# [InferenceReport](@id index)

## Summary

`InferenceReport` is a Julia package to automatically create reports based on MCMC inference methods. 


## [Installing InferenceReport](@id installing-infer)

1. If you have not done so, install [Julia](https://julialang.org/downloads/). Julia 1.9 and higher are supported. 
2. Install `InferenceReport` using

```
using Pkg; Pkg.add("InferenceReport")
```


## Usage

InferenceReport's main function is `report`. It takes one 
mandatory argument, which at the moment can be either Pigeons' 
Parallel Tempering (PT) output, or MCMCChains' Chains struct. 

We provide an example of each in the next two sections. 


### From Pigeons

First, run Parallel Tempering (PT) via [Pigeons](https://pigeons.run/dev/). 

Then call `report()` on the resulting PT struct:

```@example pigeons
using InferenceReport
using Pigeons 

pt = pigeons(
        target = toy_mvn_target(2), 
        n_rounds = 4,
        record = [traces; round_trip; record_default()])

report(pt) 
nothing # hide
```

This will generate an HTML report with various useful diagnostic 
plots and open it in your default browser. 

See `Examples` in the left side bar to see examples of such reports. 

See [`report`](@ref) for more information on the options available. 

You may also generate a TeX/PDF version using 
Documenter.jl's [TeX support](https://documenter.juliadocs.org/stable/man/other-formats/) 
as follows:

```@example pigeons
report(pt; writer=InferenceReport.Documenter.LaTeX(platform = "docker")) 
nothing # hide
```


### From MCMCChains 

[MCMCChains.jl](https://github.com/TuringLang/MCMCChains.jl) is used 
to store MCMC samples in packages such as [Turing.jl](https://github.com/TuringLang/Turing.jl). 

Simply pass it into `report` to generate and open an HTML report:

```@example turing
using InferenceReport
using Turing 
using MCMCChains

# example from Turing.jl's webpage
@model function coinflip(; N::Int)
    p ~ Beta(1, 1)
    y ~ filldist(Bernoulli(p), N)
    return y
end;

y = Bool[1, 1, 1, 0, 0, 1]
model = coinflip(; N=length(y)) | (; y)
chain = sample(model, NUTS(), 100; progress=false)

report(chain) 
nothing # hide
```

## Target descriptions 

Two methods are available to specify descriptions for target 
distributions. 

First, a [`TargetDescription`](@ref) can be passed in as argument:

```@example descriptions
using InferenceReport
using Pigeons

target = toy_mvn_target(2)
pt = pigeons(; target, n_rounds = 2)

target_description = TargetDescription(
    text = """
    The model description can use math: ``x^2``. 
    """)
report(pt; target_description)

nothing #hide
```

Sometimes we may have a family of targets (e.g., in the above 
example, normals 
indexed by their dimensionality) and would like the 
documentation to be automatically generated based on the parameters. 

To do so, implement your own [`pigeons_target_description`](@ref) 
as done in the following example:

```@example descriptions
using InferenceReport
using Pigeons

target = toy_mvn_target(2)
pt = pigeons(; target, n_rounds = 2)

const MyTargetType = typeof(target)
InferenceReport.pigeons_target_description(target::MyTargetType) = TargetDescription(
    text = """
    Some description. 

    It can use information in the target, e.g. here 
    to report that its dimension is: $(target.dim)
    """
)

nothing #hide
```


## Adding references to a bibliography

To create a bibliography, we provide automatic integration with 
[DocumenterCitations](https://juliadocs.org/DocumenterCitations.jl/stable/). 

In the target description's text, use a syntax like 
```
[bib_key](@citet)
```
to include a citation (see DocumenterCitations for 
[more citation styles](https://juliadocs.org/DocumenterCitations.jl/stable/gallery/)). 
Then pass include the contents of bibtex file to 
[`pigeons_target_description`](@ref)'s  `bibliography` argument.

```@example bib
using InferenceReport
using Pigeons

target = toy_mvn_target(2)
pt = pigeons(; target, n_rounds = 2)

report(pt; 
    target_description = TargetDescription(
        text = """
        The model description can use math: ``x^2``.
        Citation: [neal_slice_2003](@citet)
        """, 
        bibliography = InferenceReport.example_bib()
    ))

nothing #hide
```

See `funnel_model` and `Bibliography` in the navigation bar to see examples 
of linked bibliographic 
items. 


## Reproducibility instructions 

Simple Pigeons reproducibility instructions can be added to the generated page. 
This is done via the `reproducibility_command` argument to [`report`](@ref). 
This should be a string showing how to create an 
[Inputs](https://pigeons.run/dev/reference/#Pigeons.Inputs) struct. 
When `reproducibility_command` is provided, `InferenceReport` will 
combine it to information queried in the current git repository to 
attempt to string together a mini-script that can be used to reproduce the 
result. 

To help filling `reproducibility_command`, we provide a macro, 
`@reproducible`, which, given an expression, 
produces a pair containing the verbatim expression as well as its string value. 
Here his an example:

```@example macro 
using InferenceReport
using Pigeons 

inputs, reproducibility_command = 
        @reproducible Inputs(
            target = toy_mvn_target(1), n_rounds = 4, record = [traces])
pt = pigeons(inputs)

report(pt; reproducibility_command) 

nothing # hide
```



## Adding postprocessors 

Calling `report()` triggers a list of postprocessors, each creating a section 
in the generated report. 

To add a custom section in the report, first, create a function taking 
as input the [`PostprocessContext`](@ref) which contains all 
required information such as the MCMC traces. 

Here is an example of postprocessor outputting the number of dimensions:

```@example custom
using InferenceReport
using MCMCChains
import InferenceReport: get_chains, default_postprocessors, add_table, add_plot, add_markdown

function report_dim(context) 
    chns = get_chains(context)
    params = names(chns, :parameters)
    n_params = length(params)
    add_markdown(context; 
        title = "Dimension", 
        contents = "The target has $n_params parameters."
    )
end
```

Various utilities are available to generate contents, 
see for example [`add_table`](@ref), [`add_plot`](@ref), [`add_markdown`](@ref).

Then, to use the custom postprocessor, add it to the 
`postprocessors` argument:

```@example custom
using Pigeons 

pt = pigeons(
        target = toy_mvn_target(2), 
        n_rounds = 4,
        record = [traces; round_trip; record_default()])

report(pt; postprocessors = [report_dim; default_postprocessors()]) 
nothing # hide
```

Pull requests for additional postprocessors are welcome. 


## Documenter.jl integration 

**Note:** at the moment, this feature is supported on [Julia 1.10+ only](https://github.com/Julia-Tempering/InferenceReport.jl/pull/25). 

See our [Documenter.jl make file](https://github.com/Julia-Tempering/InferenceReport.jl/blob/main/docs/make.jl) to see how to 
integrate InferenceReport into a broader documentation page. 
The key functions used are [`headless`](@ref), 
[`report_to_docs`](@ref) and 
[`as_doc_page`](@ref). 