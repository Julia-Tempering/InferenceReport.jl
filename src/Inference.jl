"""
The object of a report created by this package:

$FIELDS
"""
@auto struct Inference 
    """ 
    Detailed algorithm that created the samples (currently assumes 
    it is a [`PT`](https://pigeons.run/dev/reference/#Pigeons.PT) struct).
    Optional, nothing if unspecfied.
    """
    algorithm 

    """
    Samples, stored in a [`Chains`](https://turinglang.org/MCMCChains.jl/stable/chains/) 
    struct. 
    """
    chains 
end

Inference(result::Result{PT}) = Inference(load(result))
Inference(algorithm) = Inference(algorithm, Chains(algorithm))
Inference(chains::Chains) = Inference(nothing, chains)