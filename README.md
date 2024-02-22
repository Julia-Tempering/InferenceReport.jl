# InferenceReport.jl

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://julia-tempering.github.io/InferenceReport.jl)
[![Build Status](https://github.com/Julia-Tempering/InferenceReport.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Julia-Tempering/InferenceReport.jl/actions/workflows/CI.yml?query=branch%3Amain)


`InferenceReport` is a Julia package to generate nice report from MCMC runs. 
Compatible with [`Pigeons.jl`](https://pigeons.run/) and 
a [`MCMCChains.jl`](https://turinglang.org/MCMCChains.jl).

Basic idea:

```
using InferenceReport
using Pigeons

pt = pigeons(target = Pigeons.toy_turing_unid_target(), record = [traces])
report(pt)
```

This will open in your browser the [following report](https://julia-tempering.github.io/InferenceReport.jl/dev/generated/toy_turing_unid_model/src/). 

[For more information, see the documentation.](https://julia-tempering.github.io/InferenceReport.jl)
