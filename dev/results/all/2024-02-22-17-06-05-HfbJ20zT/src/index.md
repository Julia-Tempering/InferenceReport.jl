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
| param\_1       | 0.0791392 | 0.354268 | 0.113288 | 6.85491       | 16.5161       | 1.14788  | missing           |
| param\_2       | 0.122547  | 0.270104 | 0.061537 | 19.2659       | 19.2659       | 1.07457  | missing           |
 

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


## Round trips 

Number of tempered restarts  
as a function of 
the adaptation round. 

```@raw html
<iframe src="n_tempered_restarts_progress.svg" style="height:500px;width:100%;"></iframe>
<a href="n_tempered_restarts_progress.svg"> 🔍 Full page </a> 
```


## Pigeons summary 

| **round** | **n\_scans** | **n\_tempered\_restarts** | **global\_barrier** | **global\_barrier\_variational** | **last\_round\_max\_time** | **last\_round\_max\_allocation** | **stepping\_stone** |
|----------:|-------------:|--------------------------:|--------------------:|---------------------------------:|---------------------------:|---------------------------------:|--------------------:|
| 1         | 2            | 0                         | 0.609292            | missing                          | 3.9974e-5                  | 11584.0                          | -1.67908            |
| 2         | 4            | 0                         | 1.27792             | missing                          | 6.463e-5                   | 18368.0                          | -1.86357            |
| 3         | 8            | 0                         | 1.3914              | missing                          | 6.6533e-5                  | 33440.0                          | -2.29016            |
| 4         | 16           | 1                         | 1.54735             | missing                          | 8.8574e-5                  | 58176.0                          | -2.26653            |
 

```@raw html
<a href="Pigeons_summary.csv">💾 CSV</a>
```


## Pigeons inputs 

| **Keys**               | **Values**                                                                                                                   |
|-----------------------:|:-----------------------------------------------------------------------------------------------------------------------------|
| extended\_traces       | false                                                                                                                        |
| checked\_round         | 0                                                                                                                            |
| extractor              | nothing                                                                                                                      |
| record                 | Function[Pigeons.traces, Pigeons.round\_trip, Pigeons.log\_sum\_ratio, Pigeons.timing\_extrema, Pigeons.allocation\_extrema] |
| multithreaded          | false                                                                                                                        |
| show\_report           | true                                                                                                                         |
| n\_chains              | 10                                                                                                                           |
| variational            | nothing                                                                                                                      |
| explorer               | nothing                                                                                                                      |
| n\_chains\_variational | 0                                                                                                                            |
| target                 | Pigeons.ScaledPrecisionNormalPath(1.0, 10.0, 2)                                                                              |
| n\_rounds              | 4                                                                                                                            |
| exec\_folder           | nothing                                                                                                                      |
| reference              | nothing                                                                                                                      |
| checkpoint             | false                                                                                                                        |
| seed                   | 1                                                                                                                            |
 

```@raw html
<a href="Pigeons_inputs.csv">💾 CSV</a>
```

