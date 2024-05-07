"""
The object of a report created by this package:

$FIELDS
"""
@auto struct Inference 
    """ 
    Algorithm that created the samples (currently assumes 
    it is a [`PT`](https://pigeons.run/dev/reference/#Pigeons.PT) struct).
    Optional, nothing if unspecfied.
    """
    algorithm 

    """
    Samples, stored in a [`Chains`](https://turinglang.org/MCMCChains.jl/stable/chains/) 
    struct. 
    """
    chains 

    """
    If the parameters were truncated via options.max_dim
    """
    truncated::Bool
end
Inference(algo, ::Nothing) =  Inference(algo, nothing, false)
Inference(algo, tuple::Tuple) = Inference(algo, tuple[1], tuple[2])

Inference(result::Result{PT}, max_dim::Int) = Inference(Pigeons.load(result), max_dim)

Inference(algorithm, max_dim::Int)      = Inference(algorithm, build_chains(algorithm, max_dim))
Inference(chains::Chains, max_dim::Int) = Inference(nothing,   truncate_if_needed(chains, max_dim))

build_chains(algorithm, max_dim) = 
    try 
        truncate_if_needed(Chains(algorithm), max_dim)
    catch e 
        println("Could not build traces: $e")
        nothing
    end

function truncate_if_needed(chain, max_dim)
    params = names(chain, :parameters)
    if length(params) > max_dim
        return chain[params[1:max_dim]], true
    else
        return chain, false
    end
end