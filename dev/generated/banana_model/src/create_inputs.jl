run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout abf9f0de20a6046d487af13562fccebc5cb0f4c3`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.stan_banana(2), variational = GaussianReference(first_tuning_round = 5), n_rounds = 10, record = [traces; round_trip; record_default()])
