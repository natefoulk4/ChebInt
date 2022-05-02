# Integration methods
using LinearAlgebra, ApproxFun


function chebInt(f, n, a, b; nelectrons=2, nIntPoints=n*1000, useSVD=false)
    S = Chebyshev(a..b)
    pts = points(S, n)
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


    funcs = Array{Function}(undef, nvals)
    for j in 1:nvals
        funcs[j] = Fun(S,ApproxFun.transform(S,(@views evs[j,:])));
    end
    bigFunc(x) = [funcs[j](x) for j in 1:nvals]
    vols = recInt(bigFunc, nIntPoints, a, b; nelectrons=nelectrons)

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