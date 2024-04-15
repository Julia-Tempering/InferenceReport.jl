run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 3e6a98a0cb2c9957a23a47a2c3e2323efbce7061`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.toy_turing_unid_target(), n_rounds = 10, record = [traces; round_trip; record_default()])
