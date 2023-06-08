function y = L(t)
    for i = 1:length(t)
            y(i)=log(%e-t(i)*(%e-1))
    end
endfunction
