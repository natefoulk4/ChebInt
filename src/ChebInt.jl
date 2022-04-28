module ChebInt

include("Meshes.jl")
include("Int_1D.jl")
include("ToyProblems.jl")

export ChebNodes1D, centeredmesh
export chebInt, recInt
export runge

end # module
