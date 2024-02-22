"""
Options to control [`report`](@ref):

$FIELDS
"""
@kwdef struct ReportOptions 
    """
    Maximum number of iterations in [`moving_pair_plot`](@ref).
    """
    max_moving_plot_iters::Int = 100

    """
    Name of the target. If nothing, [`target_name`](@ref) will 
    be used to attempt to auto-detect it via [`target_name`](@ref) 
    or [`pigeons_target_name`](@ref).
    """
    target_name::Union{String, Nothing} = nothing

    """
    Extended description of the target. If nothing, [`target_name`](@ref) will 
    be used to attempt to auto-detect it via [`target_description`](@ref) 
    or [`pigeons_target_description`](@ref).
    """
    target_description::Union{String, Nothing} = nothing

    """
    If true, the report webpage's md files are rendered into html files.
    """
    render::Bool = isinteractive[] 

    """
    If true, the report webpage will be opened automatically.
    """
    view::Bool = isinteractive[] 

    """
    The postprocessors to use. 
    Default is [`default_postprocessors`](@ref). 
    """
    postprocessors::Vector = default_postprocessors()

    """ 
    The directory where the report will be created. 
    A unique folder in `results/all` will be created by 
    default and symlinked in `results/latest`.
    """
    exec_folder::String = Pigeons.next_exec_folder()

    """
    A command to instruct users how to reproduce. 

    At the moment implicitly assumes Pigeons will be used, 
    and running these commands should return 
    the [Inputs](https://pigeons.run/dev/reference/#Pigeons.Inputs). 
    """
    reproducibility_command::Union{String, Nothing} = nothing
end