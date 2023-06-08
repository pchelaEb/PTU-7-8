function y = cp(x, AB)
    a = AB(1)
    b = AB(2)
    m = (a + b)/2
    
    for i = 1:length(x),
        if(a <= x(i)) & (x(i) <= b)then
            y(i) = 1 - ((x(i) - m) / (b - m))^2
        else
            y(i) = 0
        end
    end
endfunction
