# Utilities to index/process several folders created by multiple report() 
# In the following, collection refers to a directory containing sub-directories, 
# each created by a call to report()

# crate a df summary from a collection
function make_index(collection)
    result = DataFrame(
        name = String[],
        original_dim = Int[],
        gcb = Union{Float64, Nothing}[],
    )
    process_collection(collection) do _, info
        name = info["target_name"]
        gcb = get(info, "gcb",  nothing)
        original_dim = info["original_dim"]
        push!(result, (; 
            name,
            original_dim,
            gcb
        ))
    end
    return result
end

# get all unique bib files from a collection 
function merge_bibliography(collection) 
    result = Set{String}() 
    process_collection(collection) do _, info
        bib = get(info, "bibliography", nothing)
        if !isnothing(bib)
            push!(result, bib)
        end
    end
    return join(result, "\n")
end

function process_collection(lambda::Function, collection)
    for item in readdir(collection)
        report_dir = "$collection/$item"
        if isdir(report_dir)
            info = JSON.parsefile("$report_dir/info.json") 
            lambda(report_dir, info)
        end
    end
end
