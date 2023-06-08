function y = LR2(x, m1, m2, ls, rs, funL, funR) //pchelkina
    for i = 1:length(x)
        if m1 - ls <= x(i) & x(i) <= m1 & ls > 0
            y(i) = funL((m1 - x(i))/ls)
        elseif m1 < x(i) & x(i) <= m2 
            y(i) = 1
        elseif m2 < x(i) & x(i) <= (m2 + rs) & rs > 0
            y(i) = funR((x(i) - m2)/rs)
        else y(i) = 0
        end
    end
endfunction
