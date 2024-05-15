"""
Description of a target.

$FIELDS
"""
@kwdef struct TargetDescription

    """
    Keywords for the target.
    """
    keywords::Vector{String} = String[]

    """
    Contents of TeX `bib` file used to provide 
    bibliographical references in the text, 
    or `nothing` if no bibliography should be 
    generated.
    """
    bibliography::Union{String,Nothing} = nothing

    """
    Description of the target.
    """
    text::String

end