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
| p                               | 0.292789        | 0.912751         | 0.20705                | 0.0160499               | 0.085739        | 0.928801         |
| lp                              | -7.82877        | -5.29352         | 0.587875               | NaN                     | -8.41665        | NaN              |
| n\_steps                        | 1.0             | 3.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| is\_accept                      | 1.0             | 1.0              | NaN                    | NaN                     | NaN             | NaN              |
| acceptance\_rate                | 0.270601        | 1.0              | 0.2025                 | NaN                     | 0.0681016       | NaN              |
| log\_density                    | -7.82877        | -5.29352         | 0.587875               | NaN                     | -8.41665        | NaN              |
| hamiltonian\_energy             | 5.34982         | 8.52632          | 0.0820098              | 0.798956                | 5.26781         | 9.32527          |
| hamiltonian\_energy\_error      | -0.975925       | 0.83384          | 1.16313                | 0.223336                | -2.13906        | 1.05718          |
| max\_hamiltonian\_energy\_error | -1.24804        | 2.02471          | 0.592306               | 1.02309                 | -1.84035        | 3.04779          |
| tree\_depth                     | 1.0             | 2.0              | 0.0                    | NaN                     | 1.0             | NaN              |
| numerical\_error                | 0.0             | 0.0              | NaN                    | NaN                     | NaN             | NaN              |
| step\_size                      | 1.10499         | 1.10499          | NaN                    | NaN                     | NaN             | NaN              |
| nom\_step\_size                 | 1.10499         | 1.10499          | NaN                    | NaN                     | NaN             | NaN              |
 

```@raw html
<a href="Intervals.csv">💾 CSV</a> ⏐<a href="https://xkcd.com/2110/">🔗 Info </a>
```


## Moments 


| **parameters**                  | **mean**    | **std**  | **mcse**  | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|--------------------------------:|------------:|---------:|----------:|--------------:|--------------:|---------:|------------------:|
| p                               | 0.67686     | 0.156739 | 0.0210025 | 47.9364       | 58.9391       | 1.04343  | 9.62386           |
| lp                              | -5.89589    | 0.776231 | 0.12282   | 43.1009       | 16.4027       | 1.0401   | 8.65306           |
| n\_steps                        | 1.92        | 1.00182  | 0.103764  | 93.2145       | NaN           | 0.996347 | 18.714            |
| is\_accept                      | 1.0         | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| acceptance\_rate                | 0.81609     | 0.22012  | 0.0242786 | 86.8558       | NaN           | 0.997558 | 17.4374           |
| log\_density                    | -5.89589    | 0.776231 | 0.12282   | 43.1009       | 16.4027       | 1.0401   | 8.65306           |
| hamiltonian\_energy             | 6.35283     | 0.920968 | 0.154948  | 40.3796       | 52.4503       | 1.01939  | 8.10673           |
| hamiltonian\_energy\_error      | -0.00477329 | 0.421721 | 0.0298202 | 200.0         | 101.77        | 0.990227 | 40.1526           |
| max\_hamiltonian\_energy\_error | 0.22216     | 0.776373 | 0.0808396 | 99.9782       | 92.5822       | 0.996549 | 20.0719           |
| tree\_depth                     | 1.38        | 0.487832 | 0.0495022 | 97.1161       | NaN           | 0.991632 | 19.4973           |
| numerical\_error                | 0.0         | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| step\_size                      | 1.10499     | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
| nom\_step\_size                 | 1.10499     | 0.0      | NaN       | NaN           | NaN           | NaN      | NaN               |
 

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

