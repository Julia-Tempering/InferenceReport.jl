function detectwsl()
    Sys.islinux() &&
    isfile("/proc/sys/kernel/osrelease") &&
    occursin(r"Microsoft|WSL"i, read("/proc/sys/kernel/osrelease", String))
end

function open_in_default_browser(url::AbstractString)::Bool
    try
        if Sys.isapple()
            Base.run(`open $url`)
            return true
        elseif Sys.iswindows() || detectwsl()
            Base.run(`cmd.exe /s /c start "" /b $url`)
            return true
        elseif Sys.islinux()
            browser = "xdg-open"
            if isfile(browser)
                Base.run(`$browser $url`)
                return true
            else
                @warn "Unable to find `xdg-open`. Try `apt install xdg-open`"
                return false
            end
        else
            return false
        end
    catch ex
        return false
    end
end

function as_dict(object) 
    result = Dict{Symbol,String}()
    for f in fieldnames(typeof(object)) 
        result[f] = string(getfield(object, f))
    end
    return result
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

reproducibility_command(context, ::Nothing) = 
    """
    $(git_setup_string()) 
    chains = $(context.options.reproducibility_command)
    """
    
function reproducibility_command(context, pt::PT) 
    # create the piece just for the input
    create_inputs = """
        $(git_setup_string()) 

        using Pigeons
        inputs = $(context.options.reproducibility_command)
        """
    # write to file, test it against pt's input
    create_inputs_script(context, create_inputs) 

    # TODO: JSON file for submission to the Museum?

    # then provide the rest
    return """
        $create_inputs 

        pt = pigeons(inputs)
        """
end

function git_setup_string() 
    try 
        current_commit = chomp(read(`git rev-parse HEAD`, String))
        remote_repo = chomp(read(`git config --get remote.origin.url`, String))
        cloned_name = replace(basename(remote_repo), ".git" => "")
        return """
            run(`git clone $remote_repo`)
            cd("$cloned_name")
            run(`git checkout $current_commit`)

            using Pkg 
            Pkg.activate(".")
            Pkg.instantiate()
            """
    catch 
        throw("cannot find a git remote and/or commit")
    end
end

function create_inputs_script(context, script) 
    write(output_file(context, "create_inputs", "jl"), script)
    # TODO: test it via serialization
    # temporary = tempdir() 
    # cd(temporary) do
    #     @show  temporary
    #     test_script = """
    #         $script 

    #         using Serialization 
    #         serialize("_inputs.jls", inputs)
    #         """
    #     write("_script.jl", test_script)
    #     run(`$(Pigeons.julia_cmd_no_start_up()) _script.jl`) 
    #     deserialized = deserialize("_inputs.jls") 
    #     if !Pigeons.recursive_equal(deserialized, get_pt(context).inputs)
    #         throw("could not reproduce")
    #     end
    # end
end

