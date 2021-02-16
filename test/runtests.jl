if lowercase(get(ENV, "CI", "false")) == "true"
    include("install_dependencies.jl")
end

using CrossMappings
using Test
using StatsBase

include("crossmapping.jl")
include("convergentcrossmapping.jl")
