run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 7de0ed4adecbc09ac1e16e207e80bfd4abdb10cc`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.toy_turing_unid_target(), n_rounds = 10, record = [traces; round_trip; record_default()])
