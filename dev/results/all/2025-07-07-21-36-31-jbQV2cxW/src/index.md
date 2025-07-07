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
| p                               | 0.326674        | 0.906088         | 0.208444               | 0.0618805               | 0.11823         | 0.967969         |
| lp                              | -7.80018        | -5.29266         | 1.75741                | 0.00150414              | -9.55759        | -5.29115         |
| n\_steps                        | 1.0             | 3.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| is\_accept                      | 1.0             | 1.0              | NaN                    | NaN                     | NaN             | NaN              |
| acceptance\_rate                | 0.148064        | 1.0              | 0.140921               | NaN                     | 0.00714338      | NaN              |
| log\_density                    | -7.80018        | -5.29266         | 1.75741                | 0.00150414              | -9.55759        | -5.29115         |
| hamiltonian\_energy             | 5.31455         | 9.36024          | 0.0438152              | 2.53424                 | 5.27074         | 11.8945          |
| hamiltonian\_energy\_error      | -0.887854       | 0.852615         | 0.52816                | 0.287381                | -1.41601        | 1.14             |
| max\_hamiltonian\_energy\_error | -1.06211        | 2.4874           | 0.709593               | 0.770271                | -1.7717         | 3.25767          |
| tree\_depth                     | 1.0             | 2.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| numerical\_error                | 0.0             | 0.0              | NaN                    | NaN                     | NaN             | NaN              |
| step\_size                      | 1.15282         | 1.15282          | NaN                    | NaN                     | NaN             | NaN              |
| nom\_step\_size                 | 1.15282         | 1.15282          | NaN                    | NaN                     | NaN             | NaN              |
 

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

| **parameters**                  | **mean**   | **std**     | **mcse**  | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|--------------------------------:|-----------:|------------:|----------:|--------------:|--------------:|---------:|------------------:|
| p                               | 0.618159   | 0.152691    | 0.0208586 | 58.3039       | NaN           | 1.01407  | 13.394            |
| lp                              | -5.77674   | 0.695959    | 0.128533  | 52.6579       | 33.4545       | 1.00242  | 12.0969           |
| n\_steps                        | 1.72       | 0.964836    | 0.1052    | 84.1149       | NaN           | 0.996848 | 19.3234           |
| is\_accept                      | 1.0        | 0.0         | NaN       | NaN           | NaN           | NaN      | NaN               |
| acceptance\_rate                | 0.749664   | 0.272339    | 0.0289892 | 99.3006       | NaN           | 0.999727 | 22.812            |
| log\_density                    | -5.77674   | 0.695959    | 0.128533  | 52.6579       | 33.4545       | 1.00242  | 12.0969           |
| hamiltonian\_energy             | 6.27935    | 1.15373     | 0.201797  | 45.1041       | 31.784        | 1.00367  | 10.3616           |
| hamiltonian\_energy\_error      | 0.00530201 | 0.365786    | 0.025865  | 200.0         | 69.7188       | 0.991912 | 45.9453           |
| max\_hamiltonian\_energy\_error | 0.346986   | 0.821702    | 0.0830439 | 104.852       | 52.4503       | 1.00256  | 24.0873           |
| tree\_depth                     | 1.32       | 0.468826    | 0.0515117 | 82.8346       | NaN           | 0.997255 | 19.0293           |
| numerical\_error                | 0.0        | 0.0         | NaN       | NaN           | NaN           | NaN      | NaN               |
| step\_size                      | 1.15282    | 2.23163e-16 | NaN       | NaN           | NaN           | NaN      | NaN               |
| nom\_step\_size                 | 1.15282    | 2.23163e-16 | NaN       | NaN           | NaN           | NaN      | NaN               |
 

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

