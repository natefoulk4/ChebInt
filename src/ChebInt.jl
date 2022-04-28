module ChebInt

include("Cheb.jl")
include("Int.jl")
include("ToyProblems.jl")

export ChebNodes1D, centeredmesh
export chebInt, recInt
export runge

end # module
