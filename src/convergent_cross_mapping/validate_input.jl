import Distributions: Uniform 

function validate_libsize(libsize, source, dim, τ, η, replace)
    n_available_pts = length(source) - dim*τ - abs(η)
    if libsize > n_available_pts
        if replace
            #@warn "libsize = $libsize > n_available_pts = $n_available_pts. Sampling with replacement."
        else
            throw(DomainError(libsize, "libsize = $libsize > n_available_pts = $n_available_pts. Reduce `libsize` (preferably to something much smaller than `n_available_pts = $n_available_pts`) or enable sampling with replacement."))
        end
    end
end


function validate_embedding!(E, jitter)
    
    maxval = abs(maximum(E))
    unique_pts = unique(E, dims = 2)

    if size(unique_pts, 2) < size(E, 2)
        @warn "Not all embedding points are unique. Jittering coordinates by `rand(Uniform(-$jitter*maximum(#), $jitter*maximum(E)))`"

        for i in 1:length(E)
            E[i] += rand(Uniform(-jitter*maxval, jitter*maxval))
        end
    end
end


function validate_exclusion_radius!(exclusion_radius, points_available)
    if exclusion_radius < 0
        throw(DomainError(exclusion_radius, "`exclusion_radius=$exclusion_radius`. Must be ≧ 0."))
    end
    if exclusion_radius >= ceil(Int, 0.5*points_available)
        throw(DomainError(exclusion_radius, "`exclusion_radius=$exclusion_radius >= ceil(Int, 0.5*(length(target) - dim*τ))=$points_available`. Please reduce `exclusion_radius`."))
    end
end


function validate_embedding_params(dim, τ, points_available, exclusion_radius)
    all(τ .<= 0) || throw(ArgumentError("Target time series is embedded using embedding lags τ <= 0, got τ=$τ."))
    if length(τ) > 1
        length(τ) == dim || throw(ArgumentError(("If multiple τs are given, then length(τs) must equal dim")))
    end
    if dim == 1
        @warn "`dim=$dim`, but must be at least 2 to construct an embedding."
    end
    if dim <= 0
        throw(DomainError(dim, "`dim=$dim` must be at least 2 to construct an embedding."))
    end
    if dim*maximum(τ) >= ceil(Int, 0.5*points_available)
        throw(DomainError(exclusion_radius, "`exclusion_radius=$exclusion_radius >= ceil(Int, 0.5*(length(target) - dim*τ))=$points_available`. Please reduce `exclusion_radius`."))
    end
end

function validate_uncertainty_measure(uncertainty_measure)
    if uncertainty_measure ∉ [:quantile, :std, :none]
        throw(DomainError(uncertainty_measure, "uncertainty_measure = $uncertainty_measure is invalid. Must be either :quantile, :std or :none."))
    end
end


function validate_average_measure(average_measure)
    if average_measure ∉ [:mean, :median, :none]
        throw(DomainError(average_measure, "average_measure = $average_measure is invalid. Must be either :median, :mean or :none."))
    end
end


function validate_output_selection(average_measure, uncertainty_measure, summarise)
    if ((average_measure, uncertainty_measure) == (:none, :none)) && summarise
        throw(ErrorException("Setting both average_measure and uncertainty_measure to :none while summarise = true will not produce output."))
    end
end

export
validate_libsize,
validate_embedding!,
validate_embedding_params,
validate_exclusion_radius!,
validate_uncertainty_measure,
validate_average_measure,
validate_output_selection
