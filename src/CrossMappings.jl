module CrossMappings

using Distances
using NearestNeighbors
using StateSpaceReconstruction
using Statistics
using Distributions
using StatsBase

include("convergent_cross_mapping/validate_input.jl")
include("convergent_cross_mapping/crossmapping.jl")
include("convergent_cross_mapping/convergentcrossmapping.jl")

function __init__()
    @require UncertainData="dcd9ba68-c27b-5cea-ae21-829cd07325bf" begin
        include("convergent_cross_mapping/ccm_on_uncertaindata.jl")
    end
end

end # module
