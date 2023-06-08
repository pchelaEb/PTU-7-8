function y=alpha(A)
    k=1
    T = T_Set
    H = H_Set
    for i = 1:length(r)
        for j = 1:length(r)
            if A<=T(i) then
                if A<=H(j) then
                    y(k)=[T(i);H(j)]
                    k = k+1
                end
            end
        end
    end
endfunction
