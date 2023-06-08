function y1=sFun(u,AB)
    a = AB(1)
    b = AB(2)
    for i = 1:length(u) 
        if u(i)<=a then
        y1(i)=0
        else if (a<u(i))&(u(i)<b) then
             y1(i)=(u(i)-a)/(b-a)
             else if b <= u(i) then
                  y1(i)=1
                  end
             end
        end
    end
endfunction
