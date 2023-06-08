function R = TNormZade(x,y,A,B,C,a,b,c) 
    for i = 1:length(x)
        for j = 1:length(y)
            R(i,j) = max(min(A(i),a(j)),min(B(i),b(j)),min(C(i),c(j)))
        end
    end
endfunction
