```@meta
CurrentModule = InferenceReport
```

# [InferenceReport](@id index)

## Summary

`InferenceReport` is a Julia package to automatically create reports based on MCMC inference methods. 


## [Installing InferenceReport](@id installing-infer)

1. If you have not done so, install [Julia](https://julialang.org/downloads/). Julia 1.8 and higher are supported. 
2. Install `InferenceReport` using

```
using Pkg; Pkg.add("InferenceReport")
```


## Usage

### From Pigeons

First, run Parallel Tempering (PT) via [Pigeons](https://pigeons.run/dev/). 
**Make sure to save the traces,** using the argument `record = [traces]`. 
Then call `report()` on the PT struct:

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


### From MCMCChains 

[MCMCChains.jl](https://github.com/TuringLang/MCMCChains.jl) is used 
to store MCMC samples in packages such as [Turing.jl](https://github.com/TuringLang/Turing.jl). 

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


## Adding postprocessors 

Calling `report()` triggers a list of postprocessors, each creating a section 
in the generated report. 

To add a custom section in the report, first creating a function taking 
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

Then, to use the custom postprocessor:

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

See our [Documenter.jl make file](https://github.com/Julia-Tempering/InferenceReport.jl/blob/main/docs/make.jl) to see how to 
integrate InferenceReport into a broader documentation page. 
The key functions used are [`headless`](@ref), 
[`report_to_docs`](@ref) and 
[`as_doc_page`](@ref).