function r = R_r(x,y,LI,MI,HI,LC,MC,HC)
    for i = 1:1:length(x)
        for j = 1:1:length(y)
            r(i,j) = max(min(LI(i),LC(j)),min(MI(i),MC(j)),min(HI(i),HC(j)))
        end
    end
endfunction
