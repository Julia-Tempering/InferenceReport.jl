## Description 

Some description. 

It can use information in the target, e.g. here 
to report that its dimension is: 1


## Pair plot 

Diagonal entries show estimates of the marginal 
densities as well as the (0.16, 0.5, 0.84) 
quantiles (dotted lines). 
Off-diagonal entries show estimates of the pairwise 
densities. 

Movie linked below (🍿) superimposes 
16 iterations 
of MCMC. 

```@raw html
<img src="pair_plot.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="pair_plot.png"> 🔍 Full page </a> ⏐<a href="moving_pair.mp4">🍿 Movie </a> ⏐<a href="https://sefffal.github.io/PairPlots.jl">🔗 Info </a>
```


## Trace plots 


```@raw html
<img src="trace_plot.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="trace_plot.png"> 🔍 Full page </a>  
```


## Moments 

| **parameters** | **mean**  | **std**  | **mcse** | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|---------------:|----------:|---------:|---------:|--------------:|--------------:|---------:|------------------:|
| param\_1       | 0.0163711 | 0.387225 | 0.118809 | 13.0364       | 19.2659       | 1.31409  | missing           |
 

```@raw html
<a href="Moments.csv">💾 CSV</a> 
```


## Cumulative traces 

For each iteration ``i``, shows the running average up to ``i``,
``\frac{1}{i} \sum_{n = 1}^{i} x_n``. 

```@raw html
<img src="cumulative_trace_plot.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="cumulative_trace_plot.png"> 🔍 Full page </a>  
```


## Local communication barrier 

When the global communication barrier is large, many chains may 
be required to obtain tempered restarts.

The local communication barrier can be used to visualize the cause 
of a high global communication barrier. For example, if there is a 
sharp peak close to a reference constructed from the prior, it may 
be useful to switch to a [variational approximation](https://pigeons.run/dev/variational/#variational-pt).

```@raw html
<img src="local_barrier.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="local_barrier.png"> 🔍 Full page </a>  ⏐<a href="https://pigeons.run/dev/output-pt/#Local-communication-barrier">🔗 Info </a>
```


## GCB estimation progress 

Estimate of the Global Communication Barrier (GCB) 
as a function of 
the adaptation round. 

The global communication barrier can be used 
to set the number of chains. 
The theoretical framework of [Syed et al., 2021](https://academic.oup.com/jrsssb/article/84/2/321/7056147)
yields that under simplifying assumptions, it is optimal to set the number of chains 
(the argument `n_chains` in `pigeons()`) to roughly 2Λ.

Last round estimate: ``0.6864377588831496``

```@raw html
<img src="global_barrier_progress.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="global_barrier_progress.png"> 🔍 Full page </a>  ⏐<a href="https://pigeons.run/dev/output-pt/#Global-communication-barrier">🔗 Info </a>
```


## Evidence estimation progress 

Estimate of the log normalization (computed using 
the stepping stone estimator) as a function of 
the adaptation round. 

Last round estimate: ``-1.3491244009307835``

```@raw html
<img src="stepping_stone_progress.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="stepping_stone_progress.png"> 🔍 Full page </a>  ⏐<a href="https://pigeons.run/dev/output-normalization/">🔗 Info </a>
```


## Swaps plot 


```@raw html
<img src="swaps_plot.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="swaps_plot.png"> 🔍 Full page </a>  
```


## Pigeons summary 

| **round** | **n\_scans** | **n\_tempered\_restarts** | **global\_barrier** | **global\_barrier\_variational** | **last\_round\_max\_time** | **last\_round\_max\_allocation** | **stepping\_stone** |
|----------:|-------------:|--------------------------:|--------------------:|---------------------------------:|---------------------------:|---------------------------------:|--------------------:|
| 1         | 2            | missing                   | 0.417339            | missing                          | missing                    | missing                          | -1.55799            |
| 2         | 4            | missing                   | 0.563547            | missing                          | missing                    | missing                          | -0.652982           |
| 3         | 8            | missing                   | 0.596597            | missing                          | missing                    | missing                          | -0.833103           |
| 4         | 16           | missing                   | 0.686438            | missing                          | missing                    | missing                          | -1.34912            |
 

```@raw html
<a href="Pigeons_summary.csv">💾 CSV</a> ⏐<a href="https://pigeons.run/dev/output-reports/">🔗 Info </a>
```


## Pigeons inputs 

| **Keys**               | **Values**                                      |
|-----------------------:|:------------------------------------------------|
| extended\_traces       | false                                           |
| checked\_round         | 0                                               |
| extractor              | nothing                                         |
| record                 | [Pigeons.traces]                                |
| multithreaded          | false                                           |
| show\_report           | true                                            |
| n\_chains              | 10                                              |
| variational            | nothing                                         |
| explorer               | nothing                                         |
| n\_chains\_variational | 0                                               |
| target                 | Pigeons.ScaledPrecisionNormalPath(1.0, 10.0, 1) |
| n\_rounds              | 4                                               |
| exec\_folder           | nothing                                         |
| reference              | nothing                                         |
| checkpoint             | false                                           |
| seed                   | 1                                               |
 

```@raw html
<a href="Pigeons_inputs.csv">💾 CSV</a> ⏐<a href="https://pigeons.run/dev/reference/#Pigeons.Inputs">🔗 Info </a>
```


## Reproducibility 

```
run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 622845f5987de6d218ebf65d09cd701f36702e88`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(target = toy_mvn_target(1), n_rounds = 4, record = [traces])
 

pt = pigeons(inputs)

```

