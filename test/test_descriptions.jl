using Pigeons
using DynamicPPL

@testset "Hard coded description" begin
    pt = pigeons(target = Pigeons.toy_turing_unid_target(), n_rounds = 2)
    r = report(pt; 
            view = false, 
            target_description = 
            """
            The model description can use math: ``x^2``. 
            """)
    @test contains(r.generated_markdown[1], "The model description can use math")
end

@testset "Description via dispatch" begin
    target = toy_mvn_target(2)
    pt = pigeons(; target, n_rounds = 2)

    MyTargetType = typeof(target)
    InferenceReport.pigeons_target_description(target::MyTargetType) = 
        """
        Some description. 

        It can use information in the target, e.g. here 
        to report that its dimension is: $(target.dim)
        """

    r = report(pt; 
            view = false,)
    @test contains(r.generated_markdown[1], "dimension is: 2")
end