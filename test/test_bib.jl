@testset "Bib" begin

    pt = pigeons(
            target = Pigeons.stan_funnel(2), 
            n_rounds = 3, 
            record = [traces; round_trip; record_default()]
        )

    context = report(pt; 
        bib_files = [InferenceReport.example_bib],
        view = false)
    @test "bibliography.md" in readdir(context.output_directory)

end