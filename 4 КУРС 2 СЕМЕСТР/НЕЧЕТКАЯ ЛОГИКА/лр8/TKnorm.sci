function R = TKnorm(A, B, C) //pchelkina
    for i = 1:length(C)
        R(i) = max(A(i), B(i), C(i))
    end
endfunction
