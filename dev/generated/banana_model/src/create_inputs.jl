run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 0c7301eca2344550e208ca70eff2a1ff6440f00c`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.stan_banana(2), variational = GaussianReference(first_tuning_round = 5), n_chains_variational = 10, n_rounds = 10, record = [traces; round_trip; record_default()])
