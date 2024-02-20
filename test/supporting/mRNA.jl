using Pigeons
using BridgeStan

pp = Pigeons.stan_mRNA_post_prior_pair()

inputs = Inputs(
    target = pp.posterior, 
    reference = pp.prior,
    n_rounds = 15,
    n_chains = 1,
    checkpoint = true,
    record = [traces; round_trip; record_default()])