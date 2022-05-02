using Test, ChebInt

@testset "ChebNodes" begin
    @test ChebNodes1D(3) == [-0.866025403784439, 0.0, 0.866025403784439]
    @test ChebNodes1D(3, -2, 7) == [-1.397114317029974, 2.5, 6.397114317029974]
end
@testset "meshes" begin
    @test centeredmesh(10, 0, 1)[1] == 0.05
    @test centeredmesh(10, 0, 1)[end] == 0.95
end
@testset "rectangles" begin
    res = recInt(runge, 1000, -1, 1) 
    @test res[1] ≈ 0.5493603314328083
    @test isapprox(res[2],  runge(0.0) ; rtol=1e3)
    res2 = recInt(runge, 1000, -1, 1; nelectrons=1) 
    @test isapprox(res2[1], 0.07324432682131453; rtol=1e5)
    @test isapprox(res2[2],  runge(0.5) ; rtol=1e3)
end
@testset "ChebInt" begin
    @test chebInt(runge, 1000, -1, 1) ≈ 0.54936030677803
end
