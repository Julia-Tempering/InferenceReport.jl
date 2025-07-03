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
| p                               | 0.280235        | 0.886735         | 0.111082               | 0.0195002               | 0.169153        | 0.906235         |
| lp                              | -7.53782        | -5.29323         | 1.41184                | 0.00265649              | -8.94966        | -5.29057         |
| n\_steps                        | 1.0             | 3.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| is\_accept                      | 1.0             | 1.0              | NaN                    | NaN                     | NaN             | NaN              |
| acceptance\_rate                | 0.172448        | 1.0              | 0.158201               | NaN                     | 0.0142462       | NaN              |
| log\_density                    | -7.53782        | -5.29323         | 1.41184                | 0.00265649              | -8.94966        | -5.29057         |
| hamiltonian\_energy             | 5.3137          | 8.0814           | 0.0166179              | 0.487762                | 5.29708         | 8.56916          |
| hamiltonian\_energy\_error      | -0.879117       | 1.096            | 1.04249                | 0.946672                | -1.92161        | 2.04267          |
| max\_hamiltonian\_energy\_error | -1.24512        | 2.03414          | 0.794498               | 0.90417                 | -2.03962        | 2.93831          |
| tree\_depth                     | 1.0             | 2.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| numerical\_error                | 0.0             | 0.0              | NaN                    | NaN                     | NaN             | NaN              |
| step\_size                      | 1.11313         | 1.11313          | NaN                    | NaN                     | NaN             | NaN              |
| nom\_step\_size                 | 1.11313         | 1.11313          | NaN                    | NaN                     | NaN             | NaN              |
 

```@raw html
<a href="Intervals.csv">💾 CSV</a> ⏐<a href="https://xkcd.com/2110/">🔗 Info </a>
```


## Moments 


| **parameters**                  | **mean**   | **std**  | **mcse**  | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|--------------------------------:|-----------:|---------:|----------:|--------------:|--------------:|---------:|------------------:|
| p                               | 0.635353   | 0.159727 | 0.020829  | 54.2471       | 75.0404       | 1.00752  | 12.3908           |
| lp                              | -5.79733   | 0.708545 | 0.0863458 | 55.1412       | 96.8032       | 0.990586 | 12.5951           |
| n\_steps                        | 2.0        | 1.00504  | 0.112281  | 80.1218       | NaN           | NaN      | 18.301            |
| is\_accept                      | 1.0        | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| acceptance\_rate                | 0.803933   | 0.240845 | 0.024462  | 94.055        | NaN           | 1.00535  | 21.4836           |
| log\_density                    | -5.79733   | 0.708545 | 0.0863458 | 55.1412       | 96.8032       | 0.990586 | 12.5951           |
| hamiltonian\_energy             | 6.19874    | 0.82883  | 0.103885  | 62.1917       | 78.3393       | 1.00234  | 14.2055           |
| hamiltonian\_energy\_error      | -0.0139348 | 0.469008 | 0.0340981 | 120.067       | 100.074       | 0.995929 | 27.4252           |
| max\_hamiltonian\_energy\_error | 0.237622   | 0.79812  | 0.0775868 | 97.229        | 76.6284       | 0.992079 | 22.2085           |
| tree\_depth                     | 1.46       | 0.500908 | 0.0555126 | 81.4204       | NaN           | 1.01579  | 18.5976           |
| numerical\_error                | 0.0        | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| step\_size                      | 1.11313    | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| nom\_step\_size                 | 1.11313    | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
 

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

