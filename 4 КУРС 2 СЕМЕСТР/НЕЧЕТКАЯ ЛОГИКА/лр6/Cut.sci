function res = Cut(a, x, y)
    k = 1
    for j = 1 : length(x)
        if(y(j) >= a)
            res(k) = x(j)
            k = k + 1
        end
    end
    if(k == 1)
        res = []
    end
endfunction
//pchelkina
