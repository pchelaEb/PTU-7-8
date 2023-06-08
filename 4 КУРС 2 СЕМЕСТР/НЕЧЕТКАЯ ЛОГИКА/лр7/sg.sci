function y = sg(t)//pchelkina
    if t <> 1 then
        y = %e^(1- (1/(1-t^2)))
    elseif t == 1
        y = 0 
    end
endfunction
