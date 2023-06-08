function y=smin(x1,x2,sigma) //pchelkina
    for i = 1:length(x1) 
        y(i)=(x1(i)+x2(i)-(x1(i)-x2(i)).*sgn(x1(i),x2(i),sigma))/(2)
    end
endfunction
