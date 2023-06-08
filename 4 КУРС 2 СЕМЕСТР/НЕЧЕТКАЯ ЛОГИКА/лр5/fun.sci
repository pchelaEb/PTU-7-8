// Левая функция формы - гармоническая
function y = hrm(x, m, ls, rs)
    y = zeros(size(x));
    for i = 1:length(x)
        if x(i) < m - ls || x(i) > m + rs
            y(i) = 0;
        else
            y(i) = sin(pi*(x(i)-m)/(2*ls))^2;
        end
    end
endfunction

// Правая функция формы - гипербола
function y = hyp(x, m, ls, rs)
    y = zeros(size(x));
    for i = 1:length(x)
        if x(i) < m - ls || x(i) > m + rs
            y(i) = -1;
        else
            y(i) = 2/(1+(x(i)-m)/ls+(x(i)-m)/rs)-1;
        end
    end
endfunction

// Левая функция формы - линейная
function y = lin(x, m, ls, rs)
     y = zeros(size(x));
    for i = 1:length(x)
        if x(i) < m - ls || x(i) > m + rs
            y(i) = 0;
        else
            y(i) = 1 - (x(i)-m+ls)/ls;
        end
    end
endfunction

// Правая функция формы - усеченная парабола
function y = cp(x, m, ls, rs)
     y = zeros(size(x));
    for i = 1:length(x)
        if x(i) < m - ls || x(i) > m + rs
            y(i) = 0;
        else
            y(i) = 1 - ((x(i)-m)/ls)^2;
        end
    end
endfunction
