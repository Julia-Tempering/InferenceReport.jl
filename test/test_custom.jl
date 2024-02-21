using MCMCChains
import InferenceReport: get_chains, default_postprocessors, add_table, add_plot, add_markdown

@testset "Unid" begin

    function report_dim(context) 
        chns = get_chains(context)
        params = names(chns, :parameters)
        n_params = length(params)
        add_markdown(context; 
            title = "Dimension", 
            contents = "The target has $n_params parameters."
        )
    end

    pt = pigeons(
            target = toy_mvn_target(2), 
            n_rounds = 4,
            record = [traces; round_trip; record_default()])

    context = report(pt; postprocessors = [report_dim; default_postprocessors()]) 

    @test contains(context.generated_markdown[1], "The target has 2 parameters.")

end