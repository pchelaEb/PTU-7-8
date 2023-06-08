function MaxProd = maxprod(r1,r2) 
    for i = 1:size(r1,1)
        for j = 1:size(r2,2)
            for k = 1:size(r1,2)
                A(k) = r1(i,k) * r2(k,j)
            end
            MaxProd(i,j) = max(A) 
        end
    end
endfunction
