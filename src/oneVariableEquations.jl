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

"""
newtons(f::Function, fp::Function, p0::Number, e::Number, n::Integer)

Compute the root of the given function using **Newton's method**.

Compute the root of the given function using Newton's method.
Uses the point at which tangent line intersects x-axis to find the next approximate of the root of function 'f', 
as such it requires initial approximation `p0` and `fp`, the derivative of function `f`.
Newton's method has very fast convergence provided a sufficiantly accurate initial approximation is chosen.

#ARGUMENTS
- `f::function`: function whose root needs to be found.
- `fp::function`: first derivative of a function whose root needs to be found.
- `p0::Float64`: first approximation of the root of a function.
- `e::Float64`: optional, error tolerance ``ε`` for the method, default ``10^-5``.
- `n::Integer`: optional, upper bound on the number of itterations, default `100`.


### OUTPUT:
  * `p` - approximation of the root of the function `f` (Float64) or,
  * `p` - if the first derivative if the function is `0` or,
  * `-1` - if `n` the maximum number of iterations was exceeded.
"""
function newtons(f::Function, fp::Function, p0::Number, e::Number, n::Integer)

    P = []
    
    for i in 1:n

        yp = fp(p0)
        
        if abs(yp) < e
            warn("First derivative is zero")
            return p0
        end
        
        y = f(p0)
        p1 = p0 - y / yp
        push!(P, p1)
        
        if abs(p1 - p0) < e
            return p1
        end
        
        p0 = p1
    end

    return -1
end

"""
    secant(p0::Number, p1::Number, f::Function, e::Number, n::Integer)

Compute the root of the given function using **Secant method**.

Secant method, is an Extension of Newton's method.
Insted of using a tangent line, which requres knowledge of the function's derivative, Secant method uses two values of
the initial approximation `p0` and `p1`, to find secant line and uses the intersection of the secant line and x-axis
to find the next approximation.

#ARGUMENTS
- `p0::Float64`: first approximation of the root of a function.
- `p1::Float64`: second approximation of the root of a function.
- `f::function`: equation whose root needs to be found.
- `e::Float64`: optional, error tolerance ``ε`` for the method, default ``10^-5``.
- `n::Integer`: optional, upper bound on the number of itterations, default `100`.


### OUTPUT:
  * `p` - approximation of the root of the function `f` (Float64) or,
  * `-1` - if `n` the maximum number of iterations was exceeded.
"""
function secant(p0::Number, p1::Number, f::Function, e::Number, n::Integer)
    
    y0 = f(p0)
    y1 = f(p1)
    P = []
    
    for i in 1:n
        
        p = p1 - y1*(p1-p0)/(y1 - y0)
        fy = f(p)
        p0 = p1
        p1 = p
        y0 = y1
        y1 = fy
        push!(P, p1)
        
        if(abs(p1 - p0) < e)
            return x1
        end
    end

    return -1
end