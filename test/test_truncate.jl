@testset "Truncate" begin

    inputs = Inputs(
        target = toy_mvn_target(5), 
        n_rounds = 4,
        record = [traces; round_trip; record_default()])

    pt = pigeons(inputs)

    context = report(pt; 
                max_dim = 2,
                view = false)
    @test context.inference.truncated 
    @test length(names(context.inference.chains, :parameters)) == 2


    chains = Chains(pt)
    context = report(chains; 
                max_dim = 2,
                view = false)
    @test context.inference.truncated 
    @test length(names(context.inference.chains, :parameters)) == 2


    context = report(pt; 
                max_dim = 5,
                view = false)
    @test !context.inference.truncated 

end