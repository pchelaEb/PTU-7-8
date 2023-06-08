function res = Cut(u, a, x)
    k = 1
    for j = 1 : length(x)
        if(x(j) >= a)
            res(k) = u(j)
            k = k + 1
        end
    end
    if(k == 1)
        res = []
    end
endfunction
//pchelkina
