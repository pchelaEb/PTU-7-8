function y=zFun(u,AB)
    a = AB(1)
    b = AB(2)
    for i = 1:length(u) 
        if u(i) <= a then
        y(i)=1
        else if (a<u(i))&(u(i)<b) then
             y(i)=(b-u(i))/(b-a)
             else if b<= u(i) then
                  y(i)=0
                  end
             end
        end
    end
endfunction
