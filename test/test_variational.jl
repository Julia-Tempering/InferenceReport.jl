@testset "Pigeons (variational)" begin

    inputs = Inputs(
        target = toy_mvn_target(2), 
        n_rounds = 4,
        n_chains_variational = 4,
        variational = GaussianReference(first_tuning_round = 5),
        record = [traces; round_trip; record_default()])

    pt = pigeons(inputs)

    context = report(pt; 
                view = false,
                target_description = TargetDescription(text = "Description"),
                reproducibility_command = "toy_mvn_target(2)")

    @test length(context.generated_markdown) - 2 ==    # -2 b/c of variational legs
          length(InferenceReport.default_postprocessors()) - 1 # MPI output

end