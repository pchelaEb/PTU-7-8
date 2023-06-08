function y = dubua(A, B, gama)//pchelkinaS
    for i = 1 : length(A)
        y(i) = (A(i) * B(i)) / max(A(i), B(i), gama)
    end
endfunction
