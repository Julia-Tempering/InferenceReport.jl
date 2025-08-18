run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 01f91299fe830feea85f119143b019f5ae10449a`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(; target = Pigeons.toy_turing_unid_target(), n_rounds = 10, record = [traces; round_trip; record_default()])
