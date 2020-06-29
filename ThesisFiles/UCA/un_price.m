function y = un_price(low_time)
% Rising pattern, charge as soon as arrives
low = 4;
y  = low/low_time:low/low_time :low;

end