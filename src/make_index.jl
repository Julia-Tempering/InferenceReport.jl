

function make_index(directory)
    result = DataFrame(
        name = String[],
        original_dim = Int[],
        gcb = Union{Float64,Nothing}[],
    )
    for item in readdir(directory)
        report_dir = "$directory/$item"
        if isdir(report_dir)
            info = JSON.parsefile("$report_dir/info.json") 
            name = info["target_name"]
            gcb = get(info, "gcb",  nothing)
            original_dim = info["original_dim"]
            push!(result, (; 
                name,
                original_dim,
                gcb
            ))
        end
    end
    return result
end