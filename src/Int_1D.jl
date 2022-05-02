# Integration methods
using LinearAlgebra, ApproxFun


const rungeIntAnswer = 0.54936030677800634434
const rungeHalfAnswer = 0.07324432690499149


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


    vols = zeros(nvals)
    for j in 1:nvals
        interpolatedFunction = Fun(S,ApproxFun.transform(S,(@views evs[j,:])));
        
        vols[j] = recInt(interpolatedFunction, nIntPoints, a, b)[1]
    end

    return vols[1]
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