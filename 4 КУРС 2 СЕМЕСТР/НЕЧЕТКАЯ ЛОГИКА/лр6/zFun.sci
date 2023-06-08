function y = zFun(x, AB) //pchelkina
    a = AB(1)
    b = AB(2)
    for i = 1 : length(x)
        if x(i) <= a then
            y(i) = 1
        elseif a < x(i) & x(i) < b
            y(i) = (b - x(i))/(b - a)
        elseif b <= x(i)
            y(i) = 0
        end
    end
endfunction
