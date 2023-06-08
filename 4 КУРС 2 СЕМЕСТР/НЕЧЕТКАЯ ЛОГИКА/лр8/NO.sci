function P = NO(h,m) // pchelkina
    for i = 1:length(h)
        for j = 1:length(m)
            if 60 < h(i)-m(j) & h(i)-m(j) <= 100
                P(i,j) = 0.025*(h(i)-m(j))-1.5
            elseif 100 < (h(i)-m(j)) & (h(i)-m(j)) <= 140
                P(i,j) = 3.5-0.025*(h(i)-m(j))
            else P(i,j) = 0
            end
        end
    end
endfunction
