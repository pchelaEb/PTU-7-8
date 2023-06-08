function r = mu_r(h,m)
    for i = 1:1:length(h)
        for j = 1:1:length(m)
            if 60<h(i)-m(j) & h(i)-m(j)<=100 then
                r(i,j) = 0.025*(h(i)-m(j))-1.5
            elseif 100<(h(i)-m(j)) & (h(i)-m(j))<=140 then
                r(i,j) = 3.5-0.025*(h(i)-m(j))
            else r(i,j) = 0
            end
        end
    end
endfunction
