using Pigeons

@testset "PT only" begin
    pt = pigeons(target = toy_mvn_target(1), n_rounds = 2)
    r = report(pt; view = false)
    @test length(r.generated_markdown) ≥ 4
end