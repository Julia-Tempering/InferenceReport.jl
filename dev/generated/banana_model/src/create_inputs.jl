run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout e310ad5d0d5add92e5c87f149e08603006857b68`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.stan_banana(2), variational = GaussianReference(first_tuning_round = 5), n_rounds = 10, record = [traces; round_trip; record_default()])
