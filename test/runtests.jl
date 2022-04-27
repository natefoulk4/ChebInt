using Test, ChebInt

@testset "Trivial tests" begin
    @test ChebInt.greet()+3 ==7
    @test 30/3 == 10
end
