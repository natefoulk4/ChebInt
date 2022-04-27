using Test, ChebInt

@testset "ChebNodes" begin
    @test ChebNodes1D(3) == [-0.866025403784439, 0.0, 0.866025403784439]
    @test ChebNodes1D(3, -2, 7) == [-1.397114317029974, 2.5, 6.397114317029974]
end
@testset "rectangle integration" begin
    @test rectangles(runge, 1000, -1, 1) ≈ 0.5493603314328083
end
