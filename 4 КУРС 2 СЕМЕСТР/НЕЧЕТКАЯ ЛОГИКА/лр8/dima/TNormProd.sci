function R = TNormProd(x,y,A,B,C,a,b,c) 
    for i = 1:length(x)
        for j = 1:length(y)
            R(i,j) = ((A(i) * a(j)) + (B(i) * b(j)) + (C(i) * c(j))) - ((A(i) * a(j)) * (B(i) * b(j)) * (C(i) * c(j)))
        end
    end
endfunction
