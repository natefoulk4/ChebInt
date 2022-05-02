# A series of toy problems in multiple dimensions.


const rungeEnergy = 0.54936030677800634434
const rungeHalfEnergy = 0.07324432690499149
const runge2Energy = 0.4529640278308889
const runge2FermiLevel = 0.5559844429832538

runge(x) = 1/(1 + 25*x^2)

runge2(x) = [runge(x), runge(x) + 0.5]