function y = u_tilde(x, l_s, rs, m, fun)
    for i = 1:length(x)
        if m -l_s <= x(i) & x(i) <= m & l_s > 0 then
            y(i) =fun((m - x(i))/l_s)
        elseif m < x(i) & x(i) <= m + rs & rs > 0
            y(i) = fun((x(i) - m)/rs)
        else y(i) = 0
        end
    end
endfunction
