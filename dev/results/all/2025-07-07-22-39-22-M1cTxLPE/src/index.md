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
| p                               | 0.33212         | 0.902669         | 0.0575822              | 0.0467162               | 0.274537        | 0.949386         |
| lp                              | -7.53541        | -5.29258         | 3.19074                | 0.0100804               | -10.7261        | -5.2825          |
| n\_steps                        | 1.0             | 3.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| is\_accept                      | 1.0             | 1.0              | NaN                    | NaN                     | NaN             | NaN              |
| acceptance\_rate                | 0.150003        | 1.0              | 0.146958               | NaN                     | 0.0030453       | NaN              |
| log\_density                    | -7.53541        | -5.29258         | 3.19074                | 0.0100804               | -10.7261        | -5.2825          |
| hamiltonian\_energy             | 5.31906         | 9.01093          | 0.0477114              | 2.57344                 | 5.27135         | 11.5844          |
| hamiltonian\_energy\_error      | -0.866112       | 1.10568          | 2.49207                | 0.331091                | -3.35819        | 1.43677          |
| max\_hamiltonian\_energy\_error | -0.988005       | 2.49641          | 2.49023                | 1.64922                 | -3.47823        | 4.14564          |
| tree\_depth                     | 1.0             | 2.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| numerical\_error                | 0.0             | 0.0              | NaN                    | NaN                     | NaN             | NaN              |
| step\_size                      | 1.13494         | 1.13494          | NaN                    | NaN                     | NaN             | NaN              |
| nom\_step\_size                 | 1.13494         | 1.13494          | NaN                    | NaN                     | NaN             | NaN              |
 

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

| **parameters**                  | **mean**   | **std**  | **mcse**  | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|--------------------------------:|-----------:|---------:|----------:|--------------:|--------------:|---------:|------------------:|
| p                               | 0.625841   | 0.16836  | 0.0204406 | 70.4438       | 49.6206       | 1.07179  | 15.8765           |
| lp                              | -5.88166   | 0.782066 | 0.125231  | 13.323        | 51.5563       | 1.08358  | 3.00271           |
| n\_steps                        | 1.9        | 1.0      | 0.0908447 | 121.172       | NaN           | 0.993556 | 27.3093           |
| is\_accept                      | 1.0        | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| acceptance\_rate                | 0.762057   | 0.273628 | 0.0448295 | 45.7038       | NaN           | 1.04328  | 10.3006           |
| log\_density                    | -5.88166   | 0.782066 | 0.125231  | 13.323        | 51.5563       | 1.08358  | 3.00271           |
| hamiltonian\_energy             | 6.39161    | 1.05971  | 0.426966  | 5.43725       | NaN           | 1.15749  | 1.22543           |
| hamiltonian\_energy\_error      | -0.0213394 | 0.554163 | 0.0391852 | 200.0         | 87.242        | 1.0102   | 45.0755           |
| max\_hamiltonian\_energy\_error | 0.341729   | 1.01747  | 0.118823  | 82.5718       | 76.6284       | 1.0707   | 18.6098           |
| tree\_depth                     | 1.36       | 0.482418 | 0.0463294 | 108.426       | NaN           | 1.00554  | 24.4368           |
| numerical\_error                | 0.0        | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| step\_size                      | 1.13494    | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| nom\_step\_size                 | 1.13494    | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
 

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

