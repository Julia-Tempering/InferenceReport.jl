run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout f26f12430f67a2c8c64988c8c8c1d80696a7d7fd`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(target = toy_mvn_target(1), n_rounds = 4, record = [traces])
