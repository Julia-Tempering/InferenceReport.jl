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
| p                               | 0.320278        | 0.893792         | 0.0937434              | 0.0800015               | 0.226535        | 0.973794         |
| lp                              | -7.55135        | -5.30449         | 2.40543                | 0.0127565               | -9.95678        | -5.29173         |
| n\_steps                        | 1.0             | 3.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| is\_accept                      | 1.0             | 1.0              | NaN                    | NaN                     | NaN             | NaN              |
| acceptance\_rate                | 0.406069        | 1.0              | 0.311871               | NaN                     | 0.094198        | NaN              |
| log\_density                    | -7.55135        | -5.30449         | 2.40543                | 0.0127565               | -9.95678        | -5.29173         |
| hamiltonian\_energy             | 5.34721         | 8.65363          | 0.069329               | 1.23456                 | 5.27788         | 9.88819          |
| hamiltonian\_energy\_error      | -0.668782       | 0.929286         | 1.60588                | 0.482049                | -2.27466        | 1.41134          |
| max\_hamiltonian\_energy\_error | -0.668782       | 1.03005          | 1.60588                | 0.174126                | -2.27466        | 1.20417          |
| tree\_depth                     | 1.0             | 2.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| numerical\_error                | 0.0             | 0.0              | NaN                    | NaN                     | NaN             | NaN              |
| step\_size                      | 1.00749         | 1.00749          | NaN                    | NaN                     | NaN             | NaN              |
| nom\_step\_size                 | 1.00749         | 1.00749          | NaN                    | NaN                     | NaN             | NaN              |
 

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
| p                               | 0.61576    | 0.161838 | 0.0214885 | 60.1265       | 66.9638       | 0.996865 | 13.4151           |
| lp                              | -5.81593   | 0.702803 | 0.0833831 | 73.7861       | 78.3393       | 0.990802 | 16.4628           |
| n\_steps                        | 2.0        | 1.00504  | 0.0987804 | 103.52        | NaN           | NaN      | 23.0968           |
| is\_accept                      | 1.0        | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| acceptance\_rate                | 0.857445   | 0.193534 | 0.0198032 | 92.2995       | NaN           | 1.02643  | 20.5934           |
| log\_density                    | -5.81593   | 0.702803 | 0.0833831 | 73.7861       | 78.3393       | 0.990802 | 16.4628           |
| hamiltonian\_energy             | 6.25361    | 0.902058 | 0.12678   | 51.0417       | NaN           | 1.00061  | 11.3881           |
| hamiltonian\_energy\_error      | 0.00443818 | 0.380632 | 0.0269147 | 180.815       | 50.8729       | 0.990108 | 40.3424           |
| max\_hamiltonian\_energy\_error | 0.119553   | 0.509208 | 0.0400977 | 131.858       | 64.2679       | 1.00618  | 29.4194           |
| tree\_depth                     | 1.44       | 0.498888 | 0.0508534 | 96.2424       | NaN           | 0.991558 | 21.4731           |
| numerical\_error                | 0.0        | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| step\_size                      | 1.00749    | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| nom\_step\_size                 | 1.00749    | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
 

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

