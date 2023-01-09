function divided_diff(X, Y)
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

function hermite_polynomeial(X, F, Fp)
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

x = [1.3, 1.6, 1.9]
y = [0.6200860, 0.4554022, 0.2818186]
yp = [-0.5220232, -0.5698959, -0.5811571]
hermite_polynomeial(x, y, yp)