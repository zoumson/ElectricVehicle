function y = per(val1, val2)

% Relative reduction in cost compared to UCA 
y = 100*(val1-val2)./val1;

end