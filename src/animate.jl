using CairoMakie #GLMakie 
using PairPlots 
using Pigeons 
using MCMCChains 
using BridgeStan
using DynamicPPL

target = Pigeons.toy_stan_unid_target() #Pigeons.toy_turing_unid_target()
pt = pigeons(; target, record = [traces; record_default()], n_chains = 10)#,
#explorer = Pigeons.MALA(base_n_refresh = 1, step_size = 0.1), n_chains = 1)

c = Chains(pt)

# truth = Dict{Symbol,Float64}()
# truth[:param_1] = 0.0



# mutable struct DummyDict end

# iteration = 1

# Base.getproperty(::DummyDict, p::Symbol) = @show c[iteration, 1, 1]

# plot = PairPlots.pairplot(c, 
#     PairPlots.Truth((;
#         param_1 = c[1, 1, 1]
#     )))



# plot = PairPlots.pairplot(c, 
#             PairPlots.Truth(
#                 #(; param_1 = 0.0)
#                 truth
#                 # @lift((;
#                 #     param_1 = c[$iteration, 1, 1], 
#                 #     # param_2 = c[iteration, 2, 1],
#                 #     # param_3 = c[iteration, 3, 1]
#                 # ) )
#             ))





function moving_pair_plot(mcmc_chains)
    n = filter(x -> x != :log_density, names(mcmc_chains)) 
    
    fig = Figure(size=(800,800))
    framerate = 10
    iters = range(1, 1000)
    record(fig, "time_animation.mp4", iters; framerate) do t
        empty!(fig)
        pairplot(fig[1,1], c, 
            current_position(mcmc_chains, n, t, 1) 
        )
    end
    return fig
end

function current_position(sample_array, names, iteration_index::Int, chain_index::Int) 
    tuple_keys = Symbol[]
    tuple_values = Float64[]
    for i in eachindex(names)
        push!(tuple_keys,   names[i])
        push!(tuple_values, sample_array[iteration_index, i, chain_index])
    end
    return PairPlots.Truth((; zip(tuple_keys, tuple_values)...))
end


moving_pair_plot(c)