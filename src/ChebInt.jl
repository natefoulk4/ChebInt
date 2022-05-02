module ChebInt

include("Meshes.jl")
include("Int_1D.jl")
include("ToyProblems.jl")



export ChebNodes1D, centeredmesh
export solvecoeffs, interpolate, chebInt, recInt, rungeIntAnswer
export runge

end # module
