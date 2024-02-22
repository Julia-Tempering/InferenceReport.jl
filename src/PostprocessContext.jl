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
    Vector of Strings used internally. 
    """
    generated_markdown

    """
    The [`ReportOptions`](@ref). 
    """
    options
end

Base.show(io::IO, c::PostprocessContext) = "PostprocessContext(output_directory = $(c.output_directory))"
