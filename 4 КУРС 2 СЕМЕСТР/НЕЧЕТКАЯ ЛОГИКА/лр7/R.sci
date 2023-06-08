function y = R(t)
    for i = 1:length(t)
            y(i)=sqrt(log(t(i)+%e-t(i)*%e))
    end
endfunction
