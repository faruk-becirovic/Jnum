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