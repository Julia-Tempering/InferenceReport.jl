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
<iframe src="pair_plot.svg" style="height:500px;width:100%;"></iframe>
<a href="pair_plot.svg"> 🔍 Full page </a> ⏐<a href="moving_pair.mp4">🍿 Movie </a> ⏐<a href="https://sefffal.github.io/PairPlots.jl">🔗 Info </a>
```


## Trace plots 


```@raw html
<iframe src="trace_plot.svg" style="height:500px;width:100%;"></iframe>
<a href="trace_plot.svg"> 🔍 Full page </a>  
```


## Moments 

| **parameters** | **mean** | **std**  | **mcse**  | **ess\_bulk** | **ess\_tail** | **rhat** | **ess\_per\_sec** |
|---------------:|---------:|---------:|----------:|--------------:|--------------:|---------:|------------------:|
| p              | 0.629225 | 0.159107 | 0.0217447 | 53.3684       | 76.6284       | 1.00015  | 9.13373           |
 

```@raw html
<a href="Moments.csv">💾 CSV</a> 
```


## Cumulative traces 

For each iteration ``i``, shows the running average up to ``i``,
``\frac{1}{i} \sum_{n = 1}^{i} x_n``. 

```@raw html
<iframe src="cumulative_trace_plot.svg" style="height:500px;width:100%;"></iframe>
<a href="cumulative_trace_plot.svg"> 🔍 Full page </a>  
```

