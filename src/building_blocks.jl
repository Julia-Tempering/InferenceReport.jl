output_file(context, name, ext) = context.output_directory * "/" * file_name(name, ext)
file_name(string, ext) = replace(string, r"[^A-Za-z]" => "_") * "." * ext

add_top_title(context; title) = push!(context.generated_markdown, "# $title")

function add_table(context; table, title) 
    CSV.write(output_file(context, title, "csv"), table)
    markdown_table = pretty_table(String, table, backend = Val(:markdown), show_subheader=false)
    add_markdown(context; title, contents = markdown_table)
end

function add_plot(context; file, title, description = "")
    add_markdown(context; 
        title, 
        contents = """
            $description
            ```@raw html
            <iframe src="../$file" style="height:500px;width:100%;"></iframe>
            <a href="../$file">🔍</a>
            ```
            """
    )
end

function add_markdown(context; title, contents)
    markdown = """
    ## $title 

    $contents
    """
    push!(context.generated_markdown, markdown)
end

