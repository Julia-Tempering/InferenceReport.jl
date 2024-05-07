
const registered_bib_files = Set{String}()

register_bib_file!(bibfile) = push!(registered_bib_files, bibfile)

"""
$SIGNATURES 

Cite entry `key` in the given `bibfile`.
"""
cite!(bibfile, key::Symbol) = cite!(bibfile, string(key)) 
function cite!(bibfile, key::String) 
    register_bib_file!(bibfile)
    return "[$key](@cite)"
end

function make_doc_plugins()
    if isempty(registered_bib_files)
        return []
    end
    temp = tempname()
    for bib_file in registered_bib_files 
        write(temp, read(bib_file, String) * "\n")
    end
    bib = CitationBibliography(temp; style = :authoryear)
    return [bib]
end

