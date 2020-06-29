function output = normal_price(low, high, low_time, high_time, last_time)
%% TOU Without any modification, used to calculate the real cost
% When modified price is used for scheduling
v1 = low*ones(1, low_time);
v2 = high*ones(1, high_time);
v3 = cat(2, v1, v2);
v4 = low*ones(1, last_time);
output = cat(2, v3, v4);

end