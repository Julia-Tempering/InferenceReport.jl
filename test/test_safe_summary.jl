function run_mh(rng, proposal_sd, target, n_iterations, initialization) 
    target_logd(x) = logpdf(target, x)
    result = zeros(n_iterations) 
    current_point = rand(rng, initialization)
    for i in 1:n_iterations 
        proposed_point = current_point + proposal_sd * randn(rng) 
        log_ratio = target_logd(proposed_point) - target_logd(current_point) 
        if rand(rng) < exp(log_ratio) 
            current_point = proposed_point 
        end 
        result[i] = current_point 
    end
    return result
end

@testset "Safe ESS" begin 
    rng = Xoshiro(1)
    slow_mix_trace = run_mh(rng, 2.0^-20, Normal(0, 1), 100_000, Normal(0, 1))
    c = Chains(slow_mix_trace)

    # MCMCChains' default lead to catastrophic failure:
    bad_summary = summarize(c)
    bad_ess_estimate = bad_summary[:param_1, :ess_bulk] 
    @test bad_ess_estimate > 200 

    # InferenceReport defaults work much better in the low relative ESS regime: 
    better_summary = InferenceReport.safe_summarystats(c)
    @test better_summary[:param_1, :ess_bulk] < 5

end