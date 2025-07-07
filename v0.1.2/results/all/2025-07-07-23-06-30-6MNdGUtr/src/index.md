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
<img src="pair_plot.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="pair_plot.png"> 🔍 Full page </a> ⏐<a href="moving_pair.mp4">🍿 Movie </a> ⏐<a href="https://sefffal.github.io/PairPlots.jl">🔗 Info </a>
```


## Trace plots 


```@raw html
<img src="trace_plot.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="trace_plot.png"> 🔍 Full page </a>  
```


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

| **parameters**                  | **naive\_left** | **naive\_right** | **mcci\_radius\_left** | **mcci\_radius\_right** | **fused\_left** | **fused\_right** |
|--------------------------------:|----------------:|-----------------:|-----------------------:|------------------------:|----------------:|-----------------:|
| p                               | 0.265353        | 0.932816         | 0.14841                | 0.0846929               | 0.116944        | 1.01751          |
| lp                              | -8.78382        | -5.29424         | 3.41206                | 0.000904871             | -12.1959        | -5.29334         |
| n\_steps                        | 1.0             | 3.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| is\_accept                      | 1.0             | 1.0              | NaN                    | NaN                     | NaN             | NaN              |
| acceptance\_rate                | 0.316769        | 1.0              | 0.251807               | NaN                     | 0.0649616       | NaN              |
| log\_density                    | -8.78382        | -5.29424         | 3.41206                | 0.000904871             | -12.1959        | -5.29334         |
| hamiltonian\_energy             | 5.32195         | 9.24106          | 0.031825               | 1.53729                 | 5.29013         | 10.7783          |
| hamiltonian\_energy\_error      | -1.01503        | 0.84387          | 0.937998               | 0.610333                | -1.95303        | 1.4542           |
| max\_hamiltonian\_energy\_error | -1.01503        | 1.44804          | 0.901968               | 0.581056                | -1.917          | 2.02909          |
| tree\_depth                     | 1.0             | 2.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| numerical\_error                | 0.0             | 0.0              | NaN                    | NaN                     | NaN             | NaN              |
| step\_size                      | 0.914821        | 0.914821         | NaN                    | NaN                     | NaN             | NaN              |
| nom\_step\_size                 | 0.914821        | 0.914821         | NaN                    | NaN                     | NaN             | NaN              |
 

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

| **parameters**                  | **mean**   | **std**     | **mcse**    | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|--------------------------------:|-----------:|------------:|------------:|--------------:|--------------:|---------:|------------------:|
| p                               | 0.607362   | 0.174296    | 0.0216464   | 64.2276       | 47.5079       | 1.01767  | 13.4339           |
| lp                              | -5.94662   | 0.990056    | 0.125109    | 61.8197       | 70.843        | 1.01147  | 12.9303           |
| n\_steps                        | 2.3        | 0.958745    | 0.103061    | 86.5395       | NaN           | 0.990385 | 18.1007           |
| is\_accept                      | 1.0        | 0.0         | NaN         | NaN           | NaN           | NaN      | NaN               |
| acceptance\_rate                | 0.862861   | 0.189075    | 0.017347    | 60.1359       | NaN           | 1.03385  | 12.5781           |
| log\_density                    | -5.94662   | 0.990056    | 0.125109    | 61.8197       | 70.843        | 1.01147  | 12.9303           |
| hamiltonian\_energy             | 6.47419    | 1.15911     | 0.153657    | 67.9965       | 74.7352       | 1.04132  | 14.2222           |
| hamiltonian\_energy\_error      | 0.00542937 | 0.373312    | 0.0263972   | 200.0         | 95.2535       | 1.00157  | 41.8323           |
| max\_hamiltonian\_energy\_error | 0.125056   | 0.527951    | 0.0468985   | 118.105       | 91.1868       | 1.02946  | 24.7029           |
| tree\_depth                     | 1.51       | 0.502418    | 0.0497054   | 102.17        | NaN           | 0.990346 | 21.37             |
| numerical\_error                | 0.0        | 0.0         | NaN         | NaN           | NaN           | NaN      | NaN               |
| step\_size                      | 0.914821   | 1.11582e-16 | 7.71632e-17 | NaN           | NaN           | NaN      | NaN               |
| nom\_step\_size                 | 0.914821   | 1.11582e-16 | 7.71632e-17 | NaN           | NaN           | NaN      | NaN               |
 

```@raw html
<a href="Moments__MCSE__ESS__etc.csv">💾 CSV</a> 
```


## Cumulative traces 

For each iteration ``i``, shows the running average up to ``i``,
``\frac{1}{i} \sum_{n = 1}^{i} x_n``. 

```@raw html
<img src="cumulative_trace_plot.png" style="display: block; max-width:100%; max-height:500px; width:auto; height:auto;"/>
<a href="cumulative_trace_plot.png"> 🔍 Full page </a>  
```

