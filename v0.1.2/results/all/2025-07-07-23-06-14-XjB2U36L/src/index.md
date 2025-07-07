## Pair plot 

Diagonal entries show estimates of the marginal 
densities as well as the (0.16, 0.5, 0.84) 
quantiles (dotted lines). 
Off-diagonal entries show estimates of the pairwise 
densities. 

Movie linked below (🍿) superimposes 
16 iterations 
of MCMC. 

![](pair_plot.png)


## Trace plots 


![](trace_plot.png)


## Intervals 

Nominal coverage requested: 0.95 
(change via `interval_probability` option which can be passed to `report()`). 

The **credible** interval `(naive_left, naive_right)` is constructed using the quantiles 
of the posterior distribution. It is naive in the sense that it does not take 
into account additional uncertainty brought by the Monte Carlo approximation. 

The radius of a Monte Carlo **confidence interval** with the same nominal coverage, 
constructed on each of the end points of the naive interval is shown in 
`mcci_radius_left` and `mcci_radius_left`. 

Finally, `(fused_left, fused_right)` is obtained by merging the two sources of 
uncertainty: statistical, captured by the credible interval, and computational, 
captured by the confidence intervals on the end points. 

| **parameters** | **naive\_left** | **naive\_right** | **mcci\_radius\_left** | **mcci\_radius\_right** | **fused\_left** | **fused\_right** |
|---------------:|----------------:|-----------------:|-----------------------:|------------------------:|----------------:|-----------------:|
| param\_1       | -0.499512       | 0.654309         | 0.310439               | 0.213693                | -0.809951       | 0.868002         |
| param\_2       | -0.365206       | 0.612409         | 0.279569               | 0.368426                | -0.644775       | 0.980835         |
| log\_density   | -2.68178        | -0.0563243       | 0.0321988              | 0.169716                | -2.71398        | 0.113392         |
 

```@raw html
<a href="Intervals.csv">💾 CSV</a> ⏐<a href="https://xkcd.com/2110/">🔗 Info </a>
```


## Moments, MCSE, ESS, etc 

The ESS/MCSE/Rhat estimators use `InferenceReports.safe_summarystats(chains)`, which are based on 
the truncated autocorrelation estimator (Geyer, 1992, sec 3.3) computed with FFT 
with *no lag limit*.  
As a result, these estimators should be 
safe to use in the low relative ESS regime, in contrast to the defaults used in MCMCChains, 
[which lead to catastrophic ESS over-estimation in that regime](https://ubc-stat-ml.github.io/ess-bench/report.html).

| **parameters** | **mean**  | **std**  | **mcse** | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|---------------:|----------:|---------:|---------:|--------------:|--------------:|---------:|------------------:|
| param\_1       | 0.0791392 | 0.354268 | 0.113288 | 6.85491       | NaN           | 1.14788  | missing           |
| param\_2       | 0.122547  | 0.270104 | 0.061537 | 19.2659       | NaN           | 1.07457  | missing           |
| log\_density   | -1.03669  | 0.873466 | 0.2003   | 14.9962       | NaN           | 0.958739 | missing           |
 

```@raw html
<a href="Moments__MCSE__ESS__etc.csv">💾 CSV</a> 
```


## Cumulative traces 

For each iteration ``i``, shows the running average up to ``i``,
``\frac{1}{i} \sum_{n = 1}^{i} x_n``. 

![](cumulative_trace_plot.png)


## Local communication barrier 

When the global communication barrier is large, many chains may 
be required to obtain tempered restarts.

The local communication barrier can be used to visualize the cause 
of a high global communication barrier. For example, if there is a 
sharp peak close to a reference constructed from the prior, it may 
be useful to switch to a [variational approximation](https://pigeons.run/dev/variational/#variational-pt).

![](local_barrier.png)


## GCB estimation progress 

Estimate of the Global Communication Barrier (GCB) 
as a function of 
the adaptation round. 

The global communication barrier can be used 
to set the number of chains. 
The theoretical framework of [Syed et al., 2021](https://academic.oup.com/jrsssb/article/84/2/321/7056147)
yields that under simplifying assumptions, it is optimal to set the number of chains 
(the argument `n_chains` in `pigeons()`) to roughly 2Λ.

Last round estimate: ``1.5473475289306295``

![](global_barrier_progress.png)


## Evidence estimation progress 

Estimate of the log normalization (computed using 
the stepping stone estimator) as a function of 
the adaptation round. 

Last round estimate: ``-2.2665306863458055``

![](stepping_stone_progress.png)


## Round trips 

Number of tempered restarts  
as a function of 
the adaptation round. 

A tempered restart happens when a sample from the 
reference percolates to the target. When the reference 
supports iid sampling, tempered restarts can enable 
large jumps in the state space.

![](n_tempered_restarts_progress.png)


## Swaps plot 


![](swaps_plot.png)


## Pigeons summary 


| **round** | **n\_scans** | **n\_tempered\_restarts** | **global\_barrier** | **global\_barrier\_variational** | **last\_round\_max\_time** | **last\_round\_max\_allocation** | **stepping\_stone** |
|----------:|-------------:|--------------------------:|--------------------:|---------------------------------:|---------------------------:|---------------------------------:|--------------------:|
| 1         | 2            | 0                         | 0.609292            | missing                          | 3.4565e-5                  | 10048.0                          | -1.67908            |
| 2         | 4            | 0                         | 1.27792             | missing                          | 4.246e-5                   | 16064.0                          | -1.86357            |
| 3         | 8            | 0                         | 1.3914              | missing                          | 5.348e-5                   | 31392.0                          | -2.29016            |
| 4         | 16           | 1                         | 1.54735             | missing                          | 6.5202e-5                  | 55616.0                          | -2.26653            |
 

```@raw html
<a href="Pigeons_summary.csv">💾 CSV</a> ⏐<a href="https://pigeons.run/dev/output-reports/">🔗 Info </a>
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
<a href="Pigeons_inputs.csv">💾 CSV</a> ⏐<a href="https://pigeons.run/dev/reference/#Pigeons.Inputs">🔗 Info </a>
```

