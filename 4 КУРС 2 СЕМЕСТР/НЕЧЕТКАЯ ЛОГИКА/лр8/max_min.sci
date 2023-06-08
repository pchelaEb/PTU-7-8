function mm = max_min(r1,r2)
    for i = 1:1:size(r1,1)
        for j = 1:1:size(r2,2)
            for k = 1:1:size(r1,2)
                a(k) = min(r1(i,k),r2(k,j))
            end
            mm(i,j) = max(a) 
        end
    end
endfunction
