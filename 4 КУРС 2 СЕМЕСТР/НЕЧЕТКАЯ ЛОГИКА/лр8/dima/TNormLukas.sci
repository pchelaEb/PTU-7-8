function R = TNormLukas(x,y,A,B,C,a,b,c) 
    for i = 1:length(x)
        for j = 1:length(y)
            R(i,j) = min(1, max(0, A(i) + a(j)-1) + max(0, B(i) + b(j)-1) + max(0, C(i) + c(j)-1))
        end
    end
endfunction
