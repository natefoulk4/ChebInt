using Test, ChebInt

@testset "Trivial tests" begin
    @test ChebNodes1D(3) == [-0.866025403784439, 0.0, 0.866025403784439]
    @test ChebNodes1D(3, -2, 7) == [-1.397114317029974, 2.5, 6.397114317029974]
end
