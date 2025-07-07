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
    The original dimensionality of chains (the one stored might be truncated via options.max_dim)
    """
    original_dim::Int
end

istruncated(inference) = !isnothing(inference.chains) && length(names(inference.chains, :parameters)) < inference.original_dim

Inference(algo, ::Nothing) =  Inference(algo, nothing, 0)
Inference(algo, tuple::Tuple) = Inference(algo, tuple[1], tuple[2])

Inference(result::Result{PT}, max_dim::Int) = Inference(Pigeons.load(result), max_dim)

Inference(algorithm, max_dim::Int)      = Inference(algorithm, build_chains(algorithm, max_dim))
Inference(chains::Chains, max_dim::Int) = Inference(nothing,   truncate_if_needed(chains, max_dim))

function build_chains(algorithm, max_dim)
    check(algorithm)
    try 
        truncate_if_needed(Chains(algorithm), max_dim)
    catch e 
        println("Could not build traces: $e")
        nothing
    end
end
check(algorithm) = nothing 
check(pt::PT) = 
    if pt.inputs.extended_traces 
        error("Extended trace not yet supported. Please file an Issue if you need it.")
    end

function truncate_if_needed(chain, max_dim)
    params = names(chain, :parameters)
    result = length(params) > max_dim ? chain[params[1:max_dim]] : chain
    return result, length(params)
end

function warn_if_truncated(context)
    if istruncated(context.inference) 
        add_note(context, 
            title = "Truncation",
            contents = """
            For plotting, the dimensionality was truncated to the first $(context.options.max_dim) parameters. 
            Before truncation, there were $(context.inference.original_dim) parameters. 
            """
        )
    end
end