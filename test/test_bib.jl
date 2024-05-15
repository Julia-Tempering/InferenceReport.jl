@testset "Bib" begin

    pt = pigeons(
            target = Pigeons.stan_funnel(2), 
            n_rounds = 3, 
            record = [traces; round_trip; record_default()]
        )

    context = report(pt; view = false)
    @test "bibliography.md" in readdir(context.output_directory)

end

@testset "No bib" begin

    pt = pigeons(
            target = Pigeons.stan_funnel(2), 
            n_rounds = 3, 
            record = [traces; round_trip; record_default()]
        )

    context = report(pt; 
        view = false,
        target_description = TargetDescription(
                text = "No bib"
            )
    )
    @test !("bibliography.md" in readdir(context.output_directory))

end