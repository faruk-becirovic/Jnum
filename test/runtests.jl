using Jnum
using Test

f(x) = x-2^(-x)
g(x) = ℯ^x - x^2 + 3*x - 2
h(x) = 2*x*cos(2*x) - (x+1)^2
i(x) = x*cos(x) - 2*x^2 + 3*x - 1

test_bisect_intervals = [
    [0, 1],
    [0, 1],
    [-3, -2],
    [0.2, 0.3]
]

test_bisect_solutions = [
    0.641182,
    0.257530,
    -2.191307,
    0.297528
]

e = 10^(-5)

@testset "Jnum.jl" begin
    @test round(Jnum.bisect(
        test_bisect_intervals[1][1], 
        test_bisect_intervals[1][2],
        f,
        e,
        100,
    ), digits=6) == test_bisect_solutions[1]
    @test round(Jnum.bisect(
        test_bisect_intervals[2][1], 
        test_bisect_intervals[2][2],
        g,
        e,
        100,
    ), digits=6) == test_bisect_solutions[2]
    @test round(Jnum.bisect(
        test_bisect_intervals[3][1], 
        test_bisect_intervals[3][2],
        h,
        e,
        100,
    ), digits=6) == test_bisect_solutions[3]
    @test round(Jnum.bisect(
        test_bisect_intervals[4][1], 
        test_bisect_intervals[4][2],
        i,
        e,
        100,
    ), digits=6) == test_bisect_solutions[4]

end
