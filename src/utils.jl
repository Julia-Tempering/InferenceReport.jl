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
