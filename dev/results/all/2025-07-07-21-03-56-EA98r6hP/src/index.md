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
| p                               | 0.366405        | 0.893453         | 0.0657108              | 0.0360535               | 0.300694        | 0.929506         |
| lp                              | -7.28095        | -5.29418         | 0.777988               | 0.00349883              | -8.05893        | -5.29068         |
| n\_steps                        | 1.0             | 3.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| is\_accept                      | 1.0             | 1.0              | NaN                    | NaN                     | NaN             | NaN              |
| acceptance\_rate                | 0.179934        | 1.0              | 0.146924               | NaN                     | 0.0330098       | NaN              |
| log\_density                    | -7.28095        | -5.29418         | 0.777988               | 0.00349883              | -8.05893        | -5.29068         |
| hamiltonian\_energy             | 5.31552         | 8.12035          | 0.0418764              | 0.912805                | 5.27364         | 9.03316          |
| hamiltonian\_energy\_error      | -0.945719       | 1.1584           | 0.980231               | 0.441776                | -1.92595        | 1.60018          |
| max\_hamiltonian\_energy\_error | -0.993129       | 3.97937          | 1.00667                | 1.74406                 | -1.9998         | 5.72343          |
| tree\_depth                     | 1.0             | 2.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| numerical\_error                | 0.0             | 0.0              | NaN                    | NaN                     | NaN             | NaN              |
| step\_size                      | 1.22331         | 1.22331          | NaN                    | NaN                     | NaN             | NaN              |
| nom\_step\_size                 | 1.22331         | 1.22331          | NaN                    | NaN                     | NaN             | NaN              |
 

```@raw html
<a href="Intervals.csv">💾 CSV</a> ⏐<a href="https://xkcd.com/2110/">🔗 Info </a>
```


## Moments 


| **parameters**                  | **mean**    | **std**  | **mcse**  | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|--------------------------------:|------------:|---------:|----------:|--------------:|--------------:|---------:|------------------:|
| p                               | 0.64727     | 0.148085 | 0.0171585 | 87.796        | 34.2399       | 1.03744  | 20.2248           |
| lp                              | -5.7617     | 0.569787 | 0.0738375 | 71.7458       | 78.3393       | 1.10004  | 16.5275           |
| n\_steps                        | 1.8         | 0.984732 | 0.110279  | 79.7346       | NaN           | 0.996571 | 18.3678           |
| is\_accept                      | 1.0         | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| acceptance\_rate                | 0.729497    | 0.292797 | 0.0290302 | 130.563       | NaN           | 0.991528 | 30.0768           |
| log\_density                    | -5.7617     | 0.569787 | 0.0738375 | 71.7458       | 78.3393       | 1.10004  | 16.5275           |
| hamiltonian\_energy             | 6.203       | 0.841479 | 0.103811  | 47.0632       | 53.4749       | 1.04874  | 10.8416           |
| hamiltonian\_energy\_error      | -0.00697307 | 0.540711 | 0.038234  | 200.0         | 116.777       | 1.03597  | 46.0723           |
| max\_hamiltonian\_energy\_error | 0.507425    | 1.2541   | 0.109324  | 122.145       | 111.106       | 1.0057   | 28.1375           |
| tree\_depth                     | 1.24        | 0.429235 | 0.0453277 | 89.6732       | NaN           | 0.992123 | 20.6573           |
| numerical\_error                | 0.0         | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| step\_size                      | 1.22331     | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| nom\_step\_size                 | 1.22331     | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
 

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

