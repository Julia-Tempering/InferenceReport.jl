## Description 

The model description can use math: ``x^2``. 


## GCB estimation progress 

Estimate of the Global Communication Barrier (GCB) 
as a function of 
the adaptation round. 

```@raw html
<iframe src="global_barrier_progress.svg" style="height:500px;width:100%;"></iframe>
<a href="global_barrier_progress.svg"> 🔍 Full page </a> 
```


## Evidence estimation progress 

Estimate of the log normalization (computed using 
the stepping stone estimator) as a function of 
the adaptation round. 

```@raw html
<iframe src="stepping_stone_progress.svg" style="height:500px;width:100%;"></iframe>
<a href="stepping_stone_progress.svg"> 🔍 Full page </a> 
```


## Pigeons summary 

| **round** | **n\_scans** | **n\_tempered\_restarts** | **global\_barrier** | **global\_barrier\_variational** | **last\_round\_max\_time** | **last\_round\_max\_allocation** | **stepping\_stone** |
|----------:|-------------:|--------------------------:|--------------------:|---------------------------------:|---------------------------:|---------------------------------:|--------------------:|
| 1         | 2            | missing                   | 0.609292            | missing                          | 3.7961e-5                  | 11424.0                          | -1.67908            |
| 2         | 4            | missing                   | 1.27792             | missing                          | 5.0023e-5                  | 18048.0                          | -1.86357            |
 

```@raw html
<a href="Pigeons_summary.csv">💾 CSV</a>
```


## Pigeons inputs 

| **Keys**               | **Values**                                                                              |
|-----------------------:|:----------------------------------------------------------------------------------------|
| extended\_traces       | false                                                                                   |
| checked\_round         | 0                                                                                       |
| extractor              | nothing                                                                                 |
| record                 | Function[Pigeons.log\_sum\_ratio, Pigeons.timing\_extrema, Pigeons.allocation\_extrema] |
| multithreaded          | false                                                                                   |
| show\_report           | true                                                                                    |
| n\_chains              | 10                                                                                      |
| variational            | nothing                                                                                 |
| explorer               | nothing                                                                                 |
| n\_chains\_variational | 0                                                                                       |
| target                 | Pigeons.ScaledPrecisionNormalPath(1.0, 10.0, 2)                                         |
| n\_rounds              | 2                                                                                       |
| exec\_folder           | nothing                                                                                 |
| reference              | nothing                                                                                 |
| checkpoint             | false                                                                                   |
| seed                   | 1                                                                                       |
 

```@raw html
<a href="Pigeons_inputs.csv">💾 CSV</a>
```

