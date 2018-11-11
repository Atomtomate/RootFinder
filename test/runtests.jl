include("../src/RootFinder.jl")
using Test

RootFinder.main()

function f1(x, a, b)
    1.0/(x - a) - b
end

function f1_roots(a, b)
    a + 1.0/b
end

a_test = 2.3
b_test = 7.4
function f1_test(x::Real)
    f1(x, a_test, b_test)
end

@testset "RootFinder" begin
    @testset "FunctionTests" begin
        @test RootFinder.df_val(f1_test, 1.3)  ≈ [-8.4,-1] atol = 1e-12
    end;

    @testset "FixedPointSolver" begin
        @test RootFinder.fixedPointIteration(x -> x*x, 0.1) ≈ 0 atol = 1e-12
        @test RootFinder.fixedPointIteration(x -> x*x, -0.1) ≈ 0 atol = 1e-12
    end;

    @testset "NewtonMethod" begin
        @test  RootFinder.newtonStep(f1_test, 1.3) ≈ 1.3 - (8.4/1) atol = 1e-12
        @test RootFinder.newtonMethod(f1_test, 2.4) ≈ f1_roots(a_test,b_test) atol = 1e-12
        @test_throws DataType RootFinder.newtonMethod(f1_test, -10.0)
        @test_throws DataType RootFinder.newtonMethod(f1_test, 0.4)
        @test_throws DataType RootFinder.newtonMethod(f1_test, 10.0)
    end

    @testset "SecantMethod" begin
        @test RootFinder.secantStep(f1_test, -10, 10) ≈ 1.3 - (8.4/1) atol = 1e-12
        @test RootFinder.secantStep(f1_test, 0, 1) ≈ 1.3 - (8.4/1) atol = 1e-12
        @test RootFinder.secantMethod(f1_test, 2.4) ≈ f1_roots(a_test,b_test) atol = 1e-12
        @test RootFinder.secantMethod(f1_test, -10.0) ≈ f1_roots(a_test,b_test) atol = 1e-12
        @test RootFinder.secantMethod(f1_test, 0.4) ≈ f1_roots(a_test,b_test) atol = 1e-12
        @test RootFinder.secantMethod(f1_test, 10.0) ≈ f1_roots(a_test,b_test) atol = 1e-12
    end

end
