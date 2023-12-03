using Pigeons
inputs = Inputs(
    target = toy_mvn_target(3), 
    n_rounds = 4,
    record = [traces; record_default()])