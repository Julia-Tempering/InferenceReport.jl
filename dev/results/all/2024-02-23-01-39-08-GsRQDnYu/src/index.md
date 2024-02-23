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
<iframe src="pair_plot.svg" style="height:500px;width:100%;"></iframe>
<a href="pair_plot.svg"> 🔍 Full page </a> ⏐<a href="moving_pair.mp4">🍿 Movie </a>
```


## Trace plots 


```@raw html
<iframe src="trace_plot.svg" style="height:500px;width:100%;"></iframe>
<a href="trace_plot.svg"> 🔍 Full page </a> 
```


## Moments 

| **parameters** | **mean**  | **std**  | **mcse** | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|---------------:|----------:|---------:|---------:|--------------:|--------------:|---------:|------------------:|
| param\_1       | 0.0163711 | 0.387225 | 0.118809 | 13.0364       | 19.2659       | 1.31409  | missing           |
 

```@raw html
<a href="Moments.csv">💾 CSV</a>
```


## Cumulative traces 


```@raw html
<iframe src="cumulative_trace_plot.svg" style="height:500px;width:100%;"></iframe>
<a href="cumulative_trace_plot.svg"> 🔍 Full page </a> 
```


## GCB estimation progress 

Estimate of the Global Communication Barrier (GCB) 
as a function of 
the adaptation round. 

```@raw html
<iframe src="global_barrier_progress.svg" style="height:500px;width:100%;"></iframe>
<a href="global_barrier_progress.svg"> 🔍 Full page </a> 
```


## Evidence estimation progress 

Estimate of the log normalization (computed using 
the stepping stone estimator) as a function of 
the adaptation round. 

```@raw html
<iframe src="stepping_stone_progress.svg" style="height:500px;width:100%;"></iframe>
<a href="stepping_stone_progress.svg"> 🔍 Full page </a> 
```


## Pigeons summary 

| **round** | **n\_scans** | **n\_tempered\_restarts** | **global\_barrier** | **global\_barrier\_variational** | **last\_round\_max\_time** | **last\_round\_max\_allocation** | **stepping\_stone** |
|----------:|-------------:|--------------------------:|--------------------:|---------------------------------:|---------------------------:|---------------------------------:|--------------------:|
| 1         | 2            | missing                   | 0.417339            | missing                          | missing                    | missing                          | -1.55799            |
| 2         | 4            | missing                   | 0.563547            | missing                          | missing                    | missing                          | -0.652982           |
| 3         | 8            | missing                   | 0.596597            | missing                          | missing                    | missing                          | -0.833103           |
| 4         | 16           | missing                   | 0.686438            | missing                          | missing                    | missing                          | -1.34912            |
 

```@raw html
<a href="Pigeons_summary.csv">💾 CSV</a>
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
<a href="Pigeons_inputs.csv">💾 CSV</a>
```


## Reproducibility 

```
run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 324905e757a4c8e06561b5c4b2ef22e9856754e1`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(target = toy_mvn_target(1), n_rounds = 4, record = [traces])
 

pt = pigeons(inputs)

```

