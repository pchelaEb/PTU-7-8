function b = banck (U, A, B, C)//pchelkina
    i = 1
    for gama = 0 : 0.25 : 1
        D1 = dubua(A, B, gama)
        D2 = dubua(D1, C, gama)
        b(i) = Cut(max(D2), U, D2)
        i = i + 1
    end
endfunction
