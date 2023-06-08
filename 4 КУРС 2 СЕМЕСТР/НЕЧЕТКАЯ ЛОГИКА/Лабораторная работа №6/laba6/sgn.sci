function y=sgn(x1,x2,sigma)
    y=(x1-x2)/(sqrt(((x1-x2)^2)+sigma^2))
endfunction
