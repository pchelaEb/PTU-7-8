function y = sFun(x, AB) //pchelkina
    a = AB(1)
    b = AB(2)
    for i = 1 : length(x)
        if x(i) <= a then
            y(i) = 0
        elseif a < x(i) & x(i) < b
            y(i) = (x(i) - a)/(b - a)
        elseif b <= x(i)
            y(i) = 1
        end
    end
endfunction
