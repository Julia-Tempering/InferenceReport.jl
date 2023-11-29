struct MCMCChainsPostprocessor end 
function postprocess(::MCMCChainsPostprocessor, context)
    summary = summarize(context.chains) 
    add_table(context; 
        table = summary, 
        title = "Summary")
end
