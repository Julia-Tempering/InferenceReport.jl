using BridgeStan
using Pigeons 

inputs = Inputs(
    target = Pigeons.stan_funnel(1), 
    n_chains = 2,
    n_rounds = 10,
    variational = GaussianReference(first_tuning_round = 5),
    record = [traces; round_trip; record_default()])
