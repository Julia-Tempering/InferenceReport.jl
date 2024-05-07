run(`git clone https://github.com/Julia-Tempering/InferenceReport.jl`)
cd("InferenceReport.jl")
run(`git checkout e310ad5d0d5add92e5c87f149e08603006857b68`)

using Pkg 
Pkg.activate(".")
Pkg.instantiate()
 

using Pigeons
inputs = Inputs(target = toy_mvn_target(1), n_rounds = 4, record = [traces])
