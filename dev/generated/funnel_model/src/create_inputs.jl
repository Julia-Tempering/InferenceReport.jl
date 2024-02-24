run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 881ca9b392a4a59a37875104a8a5cf908ce155b3`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.stan_funnel(2), variational = GaussianReference(first_tuning_round = 5), n_rounds = 10, record = [traces; round_trip; record_default()])
