@testset "Unid" begin
    pt = pigeons(target = toy_mvn_target(2), 
            n_rounds = 4,
            record = [traces])

    c = Chains(pt) 

    for dirbuild in [() -> ".temp_$(rand())", () -> mktempdir(), () -> Pigeons.next_exec_folder()]
        for infer in [c, pt]
            @show d = dirbuild()
            report(infer; view = false, exec_folder = d)
            rm(d; recursive = true)
        end
    end
end