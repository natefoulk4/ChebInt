# Integration methods
using LinearAlgebra

include("Meshes.jl")

function solvecoeffs(xs, fxs)
    n = length(xs)
    mat = [xs[i]^(j-1) for i in 1:n, j in 1:n]
    coeffs = inv(mat) * fxs 
    return coeffs
end

function interpolate(x, C)
        answer = 0.0
        n = length(C)
        for i in 1:n
            answer += C[i]*x^(i-1)
        end
        return answer
end

function chebInt(f, n, a, b; nelectrons=2, nIntPoints=n*100)
    pts = ChebNodes1D(n,a,b)
    npts = length(pts)

    testVals = f(pts[1])
    nvals = length(testVals)
    evs = zeros(nvals, npts)
    if nelectrons/2 > nvals
        error("Expected more multivalued function")
    end

    for i in 1:npts
        evs[:,i] .= f(pts[i])
    end

    coeffs = zeros(npts, nvals)
    vols = zeros(nvals)
    for j in 1:nvals
        coeffs[:,j] = solvecoeffs(pts, (@view evs[j,:]))
        
        vols[j] = recInt(x -> interpolate(x, (@view coeffs[:,j])), nIntPoints, a, b)
    end

    return vols
end

function recInt(f, n, a, b; nelectrons=2)
    pts = centeredmesh(n,a,b)
    npts = length(pts)

    testVals = f(pts[1])
    evs = zeros(length(testVals), npts)
    if nelectrons/2 > length(testVals)
        error("Expected more multivalued function")
    end

    for i in 1:npts
        evs[:,i] .= f(pts[i])
    end

    evs = reshape(evs,npts*length(testVals))
    sort!(evs)
    numOccupiedStates = Int(round(nelectrons*length(pts)/2))
    return sum((@view evs[1:numOccupiedStates]) * (b-a)/n), evs[numOccupiedStates]
end