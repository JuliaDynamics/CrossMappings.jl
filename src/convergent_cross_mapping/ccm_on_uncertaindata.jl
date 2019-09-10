import UncertainData: 
    UncertainDataset, 
    UncertainIndexDataset, 
    UncertainValueDataset,
    resample

crossmap(source::UncertainDataset, target::UncertainDataset; kwargs...) = 
    crossmap(resample(source), resample(target); kwargs...)

crossmap(source::UncertainDataset, target; kwargs...) = 
    crossmap(resample(source), target; kwargs...)

crossmap(source, target::UncertainDataset; kwargs...) = 
    crossmap(source, resample(target); kwargs...)

crossmap(source::UncertainValueDataset, target::UncertainValueDataset; kwargs...) = 
    crossmap(resample(source), resample(target); kwargs...)

crossmap(source::UncertainValueDataset, target; kwargs...) = 
    crossmap(resample(source), target; kwargs...)

crossmap(source, target::UncertainValueDataset; kwargs...) = 
    crossmap(source, resample(target); kwargs...)

crossmap(source::UncertainIndexDataset, target::UncertainIndexDataset; kwargs...) = 
    throw(ArgumentError("Can't cross map between indices (e.g. time). That makes no sense."))


ccm(source::UncertainDataset, target::UncertainDataset, timeseries_lengths; kwargs...) = 
    ccm(resample(source), resample(target), timeseries_lengths; kwargs...)

ccm(source::UncertainDataset, target, timeseries_lengths; kwargs...) = 
    ccm(resample(source), target, timeseries_lengths; kwargs...)

ccm(source, target::UncertainDataset, timeseries_lengths; kwargs...) = 
ccm(source, resample(target), timeseries_lengths; kwargs...)

ccm(source::UncertainValueDataset, target::UncertainValueDataset, timeseries_lengths; kwargs...) = 
    ccm(resample(source), resample(target), timeseries_lengths; kwargs...)

ccm(source::UncertainValueDataset, target, timeseries_lengths; kwargs...) = 
    ccm(resample(source), target, timeseries_lengths; kwargs...)

ccm(source, target::UncertainValueDataset, timeseries_lengths; kwargs...) = 
    ccm(source, resample(target), timeseries_lengths; kwargs...)

ccm(source::UncertainIndexDataset, target::UncertainIndexDataset, timeseries_length; kwargs...) = 
    throw(ArgumentError("Can't cross map between indices (e.g. time). That makes no sense."))

