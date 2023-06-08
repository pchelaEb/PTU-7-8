function y=altha(A, R_Set, T_Set, H_Set) //pchelkina
    k = 1
    for i = 1:size(R_Set,1)
        for j = 1:size(R_Set,2)
            if A <= R_Set(i,j)
                    y(1,k) = T_Set(i)
                    y(2,k) = H_Set(j)
                    k = k + 1
            end
        end
    end
endfunction
