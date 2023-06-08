function y = R(T,H)
    C1=0
    C2=0
    C3=0
    for i = 1:length(T)
        for j = 1:length(H)
            if (T(i) <= Tcore_high)&(H(j) <= Hcore_high) then C1=1
            end
            if (T(i) > Tcore_high)&(H(j) <= Hcore_high) then C2=1
            end
            if (T(i) <= Tcore_high)&(H(j) > Hcore_high) then C3=1
            end
            if C1=1 then y(i,j)=1
                
            elseif C2=1 then y(i,j) = max(0.1-((T(i)-Tcore_high)*kT+(H(j)-Hcore_low)*0.3*kH)/((T($)-Tcore_high)+(H($)-Hcore_high)))
            
            elseif C3=1 then y(i,j) = max(0.1-((H(j)-Hcore_high)*kH+(T(i)-Tcore_low)*0.3*kT)/((H($)-Hcore_high)+(T($)-Tcore_high)))
            
            else y(i,j) = max(0.1-((T(i)-Tcore_low)*0.9*kT+(H(j)-Hcore_low)*0.9*kH)/((T($)-Tcore_low)+(H($)-Hcore_low)))
            end
            C1=0
            C2=0
            C3=0
        end
    end
endfunction
