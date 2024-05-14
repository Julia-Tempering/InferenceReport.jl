@testset "PDF output" begin

    if (get(ENV, "CI", "false") == "true") && !Sys.islinux()

        @warn "on github action CI, docker available out of the box on linux only"

    else

        inputs, reproducibility_command =
        @reproducible Inputs(
            target = toy_mvn_target(2), 
            n_rounds = 4,
            record = [traces; round_trip; record_default()])

        pt = pigeons(inputs)

        context = report(pt; 
                    view = false,
                    writer=InferenceReport.Documenter.LaTeX(platform = "docker"),
                    target_description = TargetDescription(text = "Description"),
                    reproducibility_command)

        @test isfile("$(context.options.exec_folder)/build/InferenceReport.pdf")

        @test length(context.generated_markdown) == 
            length(InferenceReport.default_postprocessors()) - 1 # MPI output
    end
end