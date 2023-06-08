function y = lenAlpha(alpha, u)
    for i = 1 : length(alpha)
        y(i) = sum(u > alpha(i)) //находим длину альфа сечения
    end
endfunction
