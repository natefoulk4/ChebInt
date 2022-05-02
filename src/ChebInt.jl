module ChebInt

include("Meshes.jl")
include("Int_1D.jl")
include("ToyProblems.jl")



export ChebNodes1D, centeredmesh
export chebInt, recInt, rungeIntAnswer, rungeHalfAnswer
export rungeEnergy, rungeHalfEnergy, runge2Energy, runge2FermiLevel, runge, runge2

end # module
