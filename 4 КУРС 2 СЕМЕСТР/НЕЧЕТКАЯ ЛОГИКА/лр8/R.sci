function y = R(T, H, Tcore_low, Hcore_low, Tcore_high, Hcore_high, kT, kH) //pchelkina
    for i = 1:length(T)
        for j = 1:length(H)
            if (T(i) <= Tcore_high)&(H(j) <= Hcore_high)
                y(i,j)=1
            elseif (T(i) > Tcore_high)&(H(j) <= Hcore_high)
                y(i,j) = max(0,1-((T(i)-Tcore_high)*kT+(H(j)-Hcore_low)*0.3*kH)/((T($)-Tcore_high)+(H($)-Hcore_high)))
            elseif (T(i) <= Tcore_high)&(H(j) > Hcore_high)
                y(i,j) = max(0,1-((H(j)-Hcore_high)*kH+(T(i)-Tcore_low)*0.3*kT)/((H($)-Hcore_high)+(T($)-Tcore_high)))
            else 
                y(i,j) = max(0,1-((T(i)-Tcore_low)*0.9*kT+(H(j)-Hcore_low)*0.9*kH)/((T($)-Tcore_low)+(H($)-Hcore_low)))
            end
        end
    end
endfunction
