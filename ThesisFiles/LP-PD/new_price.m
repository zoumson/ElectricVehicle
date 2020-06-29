function output = new_price(low, high, low_time, high_time, last_time)

% v1 = low:-low/low_time :low/low_time;
v1 = low/low_time:low/low_time :low;
% v2 = low + (high-low)/high_time:(high-low)/high_time :high;
v2 = high:-(high-low)/high_time :low + (high-low)/high_time;
v3 = cat(2, v1, v2);
v4 = low:-low/last_time :low/last_time;
output = cat(2, v3, v4);


end



