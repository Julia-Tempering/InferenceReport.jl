# Building blocks used to construct processors

output_file(context, name, ext) = context.output_directory * "/" * file_name(name, ext)
file_name(string, ext) = replace(string, r"[^A-Za-z]" => "_") * "." * ext

add_top_title(context; title) = push!(context.generated_markdown, "# $title")

"""
$SIGNATURES
"""
function add_table(context; table, title, url_help = nothing, kw_pretty_table_args...) 
    info_link = isnothing(url_help) ? "" : """⏐<a href="$url_help">🔗 Info </a>"""
    
    CSV.write(output_file(context, title, "csv"), table)
    markdown_table = 
        pretty_table(String, table; backend = Val(:markdown), show_subheader=false, kw_pretty_table_args...)
    add_markdown(context; 
        title, 
        contents = 
            """
            $markdown_table 

            ```@raw html
            <a href="$(file_name(title, "csv"))">💾 CSV</a> $info_link
            ```
            """)
end

"""
$SIGNATURES
"""
function add_plot(context; file, title, url_help = nothing, description = "", movie = nothing)
    info_link = isnothing(url_help) ? "" : """⏐<a href="$url_help">🔗 Info </a>"""
    movie_link = isnothing(movie) ? "" : """⏐<a href="$movie">🍿 Movie </a>"""
    add_markdown(context; 
        title, 
        contents = """
            $description
            ```@raw html
            <iframe src="$file" style="height:500px;width:100%;"></iframe>
            <a href="$file"> 🔍 Full page </a> $movie_link $info_link
            ```
            """
    )
end

"""
$SIGNATURES
"""
function add_markdown(context; title, contents)
    markdown = """
    ## $title 

    $contents
    """
    push!(context.generated_markdown, markdown)
end

function add_key_value(context, key, value) 
    if haskey(context.generated_dict, key) 
        @warn "key already in generated_dict: $key"
    end
    context.generated_dict[key] = value
end

"""
$SIGNATURES 
"""
target_name(context::PostprocessContext) = target_name(context.options.target_name, context.inference.algorithm) 

target_name(unspecified_name::Nothing, pt::PT) = pigeons_target_name(pt.inputs.target)
target_name(unspecified_name::Nothing, _) = "UntitledInference" 
target_name(specified_name::String, _) = specified_name 

"""
$SIGNATURES 
"""
pigeons_target_name(target::TuringLogPotential) = string(target.model.f)
pigeons_target_name(target::StanLogPotential) = clean_stan_name(string(target))
pigeons_target_name(target) = string(target)

"""
$SIGNATURES 
"""
target_description(context::PostprocessContext) = 
    add_markdown(context; 
        title = "Description", 
        contents = target_description(context.options.target_description, context.inference.algorithm)
    )

target_description(unspecified_description::Nothing, pt::PT) = pigeons_target_description(pt.inputs.target)
target_description(unspecified_description::Nothing, _) = throw("no description provided")
target_description(specified_description::String, _) = specified_description 

"""
$SIGNATURES 

By default, dispatch to `pigeons_target_description(target, Val(Symbol(pigeons_target_name(target))))`, 
to handle "vague types" such as TuringLogPotential and StanLogPotential.
"""
pigeons_target_description(target) = pigeons_target_description(target, Val(Symbol(pigeons_target_name(target))))
pigeons_target_description(target, _) = throw("no description provided")

# Some examples below of how to create description:

pigeons_target_description(target, ::Val{:toy_turing_unid_model}) =
    """
    Consider a Bayesian model where the likelihood is a binomial distribution with probability parameter ``p``. 
    Let us consider an over-parameterized model where we 
    write ``p = p_1 p_2``. Assume that each ``p_i`` has a uniform prior on the interval ``[0, 1]``.

    In summary:
    
    ```math
    \\begin{aligned}
    p_1 &\\sim \\text{Unif}(0, 1) \\\\
    p_2 &\\sim \\text{Unif}(0, 1) \\\\
    y &\\sim \\text{Bin}(n, p_1 p_2)
    \\end{aligned}
    ```

    Here we use the values: 

    | Parameter                 | Value                            | 
    |:------------------------- | :------------------------------- |
    | Number of trials ``n``    | $(target.model.args.n_trials)    |
    | Number of successes ``y`` | $(target.model.args.n_successes) |

    This is a toy example of an unidentifiable parameterization.
    In practice many popular 
    Bayesian models are unidentifiable. 

    When there are many observations, the posterior of 
    unidentifiable models concentrate on a sub-manifold, 
    making sampling difficult, as shown in the following pair plots.
    """

function pigeons_target_description(target, ::Val{:funnel_model})
    # StanLogPotential's data is a bit more ackward to access:
    data = JSON.parse(target.data.data) 
    dim = data["dim"]
    scale = data["scale"]
    """
    A synthetic target introduced 
    in [Neal, 2004](https://projecteuclid.org/journals/annals-of-statistics/volume-31/issue-3/Slice-sampling/10.1214/aos/1056562461.full)
    to benchmark algorithms on situations where the local curvature of the target density 
    varies from one part of the space to another. Specifically, the shape of the target 
    (see pair plots below) is such that when ``y < 0``, the posterior is very narrow 
    while for ``y > 0`` it is wide. 

    The funnel is formally defined as follows:
    
    ```math
    \\begin{aligned}
    y &\\sim \\text{Normal}(0, 3) \\\\
    x_i &\\sim \\text{Normal}(0, \\exp(y / \\text{scale})) \\;\\text{ for }i \\in \\{1, \\dots, d\\}  \\\\
    \\end{aligned}
    ```

    Here we use the values: 

    | Parameter                           | Value                            | 
    |:----------------------------------- | :------------------------------- |
    | Number of "``x``" dimensions, ``d`` | $(dim)                           |
    | Scale factor                        | $(scale)                         |
    
    While the example is artificial, it is useful since it combines certain features 
    present in many real challenging targets (varying local curvature), while having 
    known moments for the difficult dimension to explore, ``y`` (since ``y`` is 
    marginally a normal distribution with known moments). 

    [Stan implementation](https://github.com/Julia-Tempering/Pigeons.jl/blob/main/examples/stan/funnel.stan)
    """
end

function pigeons_target_description(target, ::Val{:banana_model})
    # StanLogPotential's data is a bit more ackward to access:
    data = JSON.parse(target.data.data) 
    dim = data["dim"]
    scale = data["scale"]
    """
    A common synthetic distribution used to benchmark MCMC methods. 
    For details on this implementation, 
    see [Pagani et al., 2021, Section 3](https://doi.org/10.1111/sjos.12532). 

    Here we use the values: 

    | Parameter                           | Value                            | 
    |:----------------------------------- | :------------------------------- |
    | Number of "``y``" dimensions, ``d`` | $(dim)                           |
    | Scale factor                        | $(scale)                         |

    [Stan implementation](https://github.com/Julia-Tempering/Pigeons.jl/blob/main/examples/stan/banana.stan)
    """
end

pigeons_target_description(target, ::Val{:eight_schools_centered_model}) =
    """
    A common posterior distribution, based on data from [Rubin, 1981](https://www.jstor.org/stable/1164617)
    used to to illustrate hierarchical 
    modelling [Gelman et al, 2013](http://www.stat.columbia.edu/~gelman/book/BDA3.pdf). 
    It is also used to benchmark MCMC methods, 
    due to a mild "funnel-type" behaviour.  
    The terminology 'centered' refers to the original parameterization, to 
    contrast with a reparameterization which is less challenging and hence 
    less interesting in an MCMC benchmarking context. 

    [Stan implementation](https://github.com/Julia-Tempering/Pigeons.jl/blob/main/examples/stan/eight_schools_centered.stan)
    [Data](https://github.com/Julia-Tempering/Pigeons.jl/blob/main/examples/stan/eight_schools.json)
    """


"""
$SIGNATURES
"""
get_pt(context::PostprocessContext) = get_pt(context.inference.algorithm) 

get_pt(unknown_algo) = throw("only applies to Pigeons")
get_pt(pt::PT) = pt

"""
$SIGNATURES
"""
get_chains(context) = 
    isnothing(context.inference.chains) ? 
    throw("no traces provided (in Pigeons, use 'record = [traces])") :
    context.inference.chains