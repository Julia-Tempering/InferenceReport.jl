run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 5ce6f92f65147e8ac6817406e056cfb3a03e0693`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.toy_turing_unid_target(), n_rounds = 10, record = [traces; round_trip; record_default()])
