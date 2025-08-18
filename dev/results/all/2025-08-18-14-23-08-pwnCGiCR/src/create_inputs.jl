run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 01f91299fe830feea85f119143b019f5ae10449a`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(target = toy_mvn_target(1), n_rounds = 4, record = [traces])
