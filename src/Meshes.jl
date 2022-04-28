function ChebNodes1D!(nodes, n, a=-1.0, b=1.0)
    for i in 1:n
        nodes[n-i+1] = round(cos((2*i-1)*pi/(2*n))*(b-a)/2  + (a+b)/2,digits=15)
    end
    return nodes
end 

ChebNodes1D(n, a=-1.0, b=1.0) = ChebNodes1D!(zeros(n), n, a, b)

function centeredmesh(n, a, b)
    step = (b-a)/n
    pts = range(a+step/2, b, step=step)
    return pts
end