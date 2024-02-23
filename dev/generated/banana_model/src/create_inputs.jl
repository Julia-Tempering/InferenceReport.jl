run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 85a7067744878df75506af1a6a4940913c9f605e`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.stan_banana(2), variational = GaussianReference(first_tuning_round = 5), n_rounds = 10, record = [traces; round_trip; record_default()])
