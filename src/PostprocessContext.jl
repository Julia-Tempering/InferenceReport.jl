"""
Information passed to the processors:

$FIELDS
"""
@auto struct PostprocessContext 
    """
    The [`Inference`](@ref) on which the report will be based on.
    """
    inference

    """
    The resolved location of the output report.  
    """
    output_directory::String

    """
    Vector of Strings used internally to create the markdown page. 
    """
    generated_markdown::Vector{String}

    """
    Generated dictionary used internally to create a JSON object for indexing 
    purposes.
    """
    generated_dict::Dict{String,Any}

    """
    The [`ReportOptions`](@ref). 
    """
    options
end

Base.show(io::IO, c::PostprocessContext) = "PostprocessContext(output_directory = $(c.output_directory))"
