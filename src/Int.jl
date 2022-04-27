# Integration methods


function rectangles(f, n, a, b)
    step = (b-a)/n
    pts = range(a+step/2, b, step=step)
    return sum(f.(pts) * step)
end