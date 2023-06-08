function R = TNorm(x,y,LI,MI,HI,LC,MC,HC) //pchelkina
    for i = 1:length(x)
        for j = 1:length(y)
            R(i,j) = max(min(LI(i),LC(j)),min(MI(i),MC(j)),min(HI(i),HC(j)))
        end
    end
endfunction
