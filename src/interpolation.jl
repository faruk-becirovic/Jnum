"""
    divided_diff(X, Y)

Generate coefficiant of the interpolating polynomial using divided difference method.

Computes interpolating polynomial passing through the points whoose coordinates are provided in `X[]` and `Y[]`
using Newton's divided difference method.  

# OUTPUT:
  * `Y` - coefficiants of the interpolating polynomial of the type `Array{Float64}`,
"""
unction divided_diff(X, Y)
    n = length(Y)
    F = copy(Y)
    
    for i in 2:n
        for j in i:n
            F[j] = (Y[j]-Y[j-1])/(X[j]-X[j-i+1])
        end
        for j in i:n
            Y[j] = F[j]
        end
    end

    return Y
end

"""
    hermit(X, F, Fp)

Generate coefficiants of the interpolating Hermite polynomials.

The computation of the interpolating polynomial is done using discrete values of the function `f`, as `F`, 
and their corresponding `x` value, in `X`, as well as the values of the differential at `x` in `Fp[]`, 
using Hermite interpolation method. 
Returns coefficiants of the Hermite polynomial. 

# OUTPUT:
  * `P` - coefficiants of the interpolating polynomial of the type `Array{Float64}`,
"""
function hermite_polynomeal(X, F, Fp)
    n = length(X)
    H = zeros(2n+2, 2n+2)
    Z = zeros(2n+2)
    
    for i in 1:n
        Z[2i-1] = X[i]
        Z[2i] = X[i]
        H[2i-1, 1] = F[i]
        H[2i, 1] = F[i]
        H[2i, 2] = Fp[i]

        if i > 1
            H[2i-1, 2] = (H[2i-1, 1] - H[2i-2, 1])/(Z[2i-1] - Z[2i-2])
        end
    end

    for i in 3:2n
        for j in 3:i
            H[i, j] = (H[i, j-1] - H[i-1, j-1])/(Z[i] - Z[i-j+1])
        end
    end

    P = []

    for i in 1:2n
        push!(P, H[i, i])
    end

    return P
end
