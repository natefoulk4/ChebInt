# Integration methods

function centeredmesh(n, a, b)
    step = (b-a)/n
    pts = range(a+step/2, b, step=step)
    return pts
end

function rectangles(f, n, a, b; nelectrons=2)
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