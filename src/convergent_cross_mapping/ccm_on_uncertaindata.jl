import UncertainData: 
    UncertainDataset, 
    UncertainIndexDataset, 
    UncertainValueDataset,
    resample

crossmap(driver::UncertainDataset, response::UncertainDataset; kwargs...) = 
    crossmap(resample(driver), resample(response); kwargs...)

crossmap(driver::UncertainDataset, response; kwargs...) = 
    crossmap(resample(driver), response; kwargs...)

crossmap(driver, response::UncertainDataset; kwargs...) = 
    crossmap(driver, resample(response); kwargs...)

crossmap(driver::UncertainValueDataset, response::UncertainValueDataset; kwargs...) = 
    crossmap(resample(driver), resample(response); kwargs...)

crossmap(driver::UncertainValueDataset, response; kwargs...) = 
    crossmap(resample(driver), response; kwargs...)

crossmap(driver, response::UncertainValueDataset; kwargs...) = 
    crossmap(driver, resample(response); kwargs...)

crossmap(driver::UncertainIndexDataset, response::UncertainIndexDataset; kwargs...) = 
    throw(ArgumentError("Can't cross map between indices (e.g. time). That makes no sense."))


ccm(driver::UncertainDataset, response::UncertainDataset, timeseries_lengths; kwargs...) = 
    ccm(resample(driver), resample(response), timeseries_lengths; kwargs...)

ccm(driver::UncertainDataset, response, timeseries_lengths; kwargs...) = 
    ccm(resample(driver), response, timeseries_lengths; kwargs...)

ccm(driver, response::UncertainDataset, timeseries_lengths; kwargs...) = 
ccm(driver, resample(response), timeseries_lengths; kwargs...)

ccm(driver::UncertainValueDataset, response::UncertainValueDataset, timeseries_lengths; kwargs...) = 
    ccm(resample(driver), resample(response), timeseries_lengths; kwargs...)

ccm(driver::UncertainValueDataset, response, timeseries_lengths; kwargs...) = 
    ccm(resample(driver), response, timeseries_lengths; kwargs...)

ccm(driver, response::UncertainValueDataset, timeseries_lengths; kwargs...) = 
    ccm(driver, resample(response), timeseries_lengths; kwargs...)

ccm(driver::UncertainIndexDataset, response::UncertainIndexDataset, timeseries_length; kwargs...) = 
    throw(ArgumentError("Can't cross map between indices (e.g. time). That makes no sense."))

