using Pigeons
using DynamicPPL
inputs = Inputs(
    target = Pigeons.toy_turing_unid_target(), 
    n_rounds = 10,
    record = [traces; round_trip; record_default()])