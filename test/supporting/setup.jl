using InferenceReport 
using Pigeons 
using Test
using MCMCChains
using BridgeStan

is_windows_in_CI() = Sys.iswindows() && (get(ENV, "CI", "false") == "true")
