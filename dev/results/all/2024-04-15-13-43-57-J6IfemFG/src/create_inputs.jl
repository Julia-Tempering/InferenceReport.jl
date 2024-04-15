run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout 3e6a98a0cb2c9957a23a47a2c3e2323efbce7061`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(target = toy_mvn_target(1), n_rounds = 4, record = [traces])
