## Dimension 

The target has 2 parameters.

## Pair plot 

Diagonal entries show estimates of the marginal 
densities as well as the (0.16, 0.5, 0.84) 
quantiles (dotted lines). 
Off-diagonal entries show estimates of the pairwise 
densities. 

Movie linked below (🍿) superimposes 
100 iterations 
of MCMC. 

```@raw html
<iframe src="../pair_plot.svg" style="height:500px;width:100%;"></iframe>
<a href="../pair_plot.svg"> 🔍 Full page </a> ⏐<a href="../moving_pair.mp4">🍿 Movie </a>
```


## Trace plots 


```@raw html
<iframe src="../trace_plot.svg" style="height:500px;width:100%;"></iframe>
<a href="../trace_plot.svg"> 🔍 Full page </a> 
```


## Moments 

| **parameters** | **mean**   | **std**  | **mcse**  | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|---------------:|-----------:|---------:|----------:|--------------:|--------------:|---------:|------------------:|
| param\_1       | -0.0113006 | 0.320156 | 0.0103046 | 969.233       | 753.768       | 0.999572 | missing           |
| param\_2       | 0.00554316 | 0.333108 | 0.0103064 | 1042.98       | 937.659       | 1.00306  | missing           |
 

```@raw html
<a href="../Moments.csv">💾 CSV</a>
```


## Cumulative traces 


```@raw html
<iframe src="../cumulative_trace_plot.svg" style="height:500px;width:100%;"></iframe>
<a href="../cumulative_trace_plot.svg"> 🔍 Full page </a> 
```


## GCB estimation progress 

Estimate of the Global Communication Barrier (GCB) 
as a function of 
the adaptation round. 

```@raw html
<iframe src="../global_barrier_progress.svg" style="height:500px;width:100%;"></iframe>
<a href="../global_barrier_progress.svg"> 🔍 Full page </a> 
```


## Evidence estimation progress 

Estimate of the log normalization (computed using 
the stepping stone estimator) as a function of 
the adaptation round. 

```@raw html
<iframe src="../stepping_stone_progress.svg" style="height:500px;width:100%;"></iframe>
<a href="../stepping_stone_progress.svg"> 🔍 Full page </a> 
```


## Round trips 

Number of tempered restarts  
as a function of 
the adaptation round. 

```@raw html
<iframe src="../n_tempered_restarts_progress.svg" style="height:500px;width:100%;"></iframe>
<a href="../n_tempered_restarts_progress.svg"> 🔍 Full page </a> 
```


## Pigeons summary 

| **round** | **n\_scans** | **n\_tempered\_restarts** | **global\_barrier** | **global\_barrier\_variational** | **last\_round\_max\_time** | **last\_round\_max\_allocation** | **stepping\_stone** |
|----------:|-------------:|--------------------------:|--------------------:|---------------------------------:|---------------------------:|---------------------------------:|--------------------:|
| 1         | 2            | 0                         | 0.609292            | missing                          | 3.2952e-5                  | 11584.0                          | -1.67908            |
| 2         | 4            | 0                         | 1.27792             | missing                          | 4.5585e-5                  | 18368.0                          | -1.86357            |
| 3         | 8            | 0                         | 1.3914              | missing                          | 5.3059e-5                  | 33440.0                          | -2.29016            |
| 4         | 16           | 1                         | 1.54735             | missing                          | 6.7717e-5                  | 58176.0                          | -2.26653            |
| 5         | 32           | 4                         | 1.21543             | missing                          | 0.000102801                | 77392.0                          | -2.26711            |
| 6         | 64           | 9                         | 1.10425             | missing                          | 0.000159077                | 87840.0                          | -2.09087            |
| 7         | 128          | 26                        | 1.09871             | missing                          | 0.000225711                | 98128.0                          | -2.35897            |
| 8         | 256          | 52                        | 1.17459             | missing                          | 0.00036953                 | 103776.0                         | -2.23191            |
| 9         | 512          | 115                       | 1.08075             | missing                          | 0.000690469                | 172768.0                         | -2.33425            |
| 10        | 1024         | 228                       | 1.13817             | missing                          | 0.0012917                  | 173312.0                         | -2.30022            |
 

```@raw html
<a href="../Pigeons_summary.csv">💾 CSV</a>
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
| n\_rounds              | 10                                                                                                                           |
| exec\_folder           | nothing                                                                                                                      |
| reference              | nothing                                                                                                                      |
| checkpoint             | false                                                                                                                        |
| seed                   | 1                                                                                                                            |
 

```@raw html
<a href="../Pigeons_inputs.csv">💾 CSV</a>
```

