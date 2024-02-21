output_file(context, name, ext) = context.output_directory * "/" * file_name(name, ext)
file_name(string, ext) = replace(string, r"[^A-Za-z]" => "_") * "." * ext

add_top_title(context; title) = push!(context.generated_markdown, "# $title")

"""
$SIGNATURES
"""
function add_table(context; table, title, kw_pretty_table_args...) 
    CSV.write(output_file(context, title, "csv"), table)
    markdown_table = 
        pretty_table(String, table; backend = Val(:markdown), show_subheader=false, kw_pretty_table_args...)
    add_markdown(context; 
        title, 
        contents = 
            """
            $markdown_table 

            ```@raw html
            <a href="../$(file_name(title, "csv"))">💾 CSV</a>
            ```
            """)
end

"""
$SIGNATURES
"""
function add_plot(context; file, title, description = "", movie = nothing)
    movie_link = isnothing(movie) ? "" : """⏐<a href="../$movie">🍿 Movie </a>"""
    add_markdown(context; 
        title, 
        contents = """
            $description
            ```@raw html
            <iframe src="../$file" style="height:500px;width:100%;"></iframe>
            <a href="../$file"> 🔍 Full page </a> $movie_link
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

