@testset "PDF output" begin
    # using platform="native" is not great because it assumes various dependencies
    # are installed (e.g. pygmentize)
    if Sys.which("docker") === nothing

        @warn "docker not found; skipping test."

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
                    target_description = "Description",
                    reproducibility_command)

        @test isfile("$(context.options.exec_folder)/build/InferenceReport.pdf")

        @test length(context.generated_markdown) == 
            length(InferenceReport.default_postprocessors()) - 1 # MPI output
    end
end