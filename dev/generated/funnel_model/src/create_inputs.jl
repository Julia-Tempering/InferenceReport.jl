run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout dff30e31a2cb0d9c945bcfc6df191ab814f8b7bc`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.stan_funnel(2), variational = GaussianReference(first_tuning_round = 5), n_chains_variational = 10, n_rounds = 10, record = [traces; round_trip; record_default()])
