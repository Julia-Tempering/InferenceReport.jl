@testset "Pigeons" begin

    inputs = Inputs(
        target = toy_mvn_target(2), 
        n_rounds = 4,
        record = [traces; round_trip; record_default()])

    pt = pigeons(inputs)

    context = report(pt; 
                view = false,
                reproducibility_command = "toy_mvn_target(2)")

    @test length(context.generated_markdown) == 
          length(InferenceReport.default_postprocessors()) - 1 # MPI output

end