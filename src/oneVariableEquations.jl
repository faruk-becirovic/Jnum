"""
    bisect(a::Float64, b:Float64, f::Function[, e::Float64, n::Integer])

Compute the root of the given function using **Bisection method**.

Uses midpoint of the interval [`a`, `b`], replacing one of the
endpoinds with midpoint depending on the location of the root in
relation to the midpoint and repeting the process untill the
approximation `p` of the root of the function `f` is found
within the specified error margin.

#ARGUMENTS
- `a::Float64`: lower bound of the interval.
- `b::Float64`: upper bound of the interval.
- `f::function`: equation whose root needs to be found.
- `e::Float64`: optional, error tolerance ``ε`` for the method, default ``10^-5``.
- `n::Integer`: optional, upper bound on the number of itterations, default `100`.

# OUTPUT:
  * `p` - approximation of the root of the function `f` (Float64) or,
  * `-1` - if `n` the maximum number of iterations was exceeded.
"""
function bisect(a, b, f::Function, e, n::Integer)

    Ap = []
    
    for i in 1:n
        
        p = a + 0.5*(b-a)
        ei = (b-a)/2
        push!(Ap, p)

        if ei < e
            return p
        end

        if sign(f(a))*sign(f(p)) < 0
            b = p
        else
            a = p
        end
        
    end

    return -1
end
