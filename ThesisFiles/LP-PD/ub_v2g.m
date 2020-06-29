function output = ub_v2g(pmax, arrival, departure,low_time,high_time, last_time)
%% ESS providing V2G service sells power only when price are high otherwise 
% During High Price Upper Bound is set to pmax
% During low Price upper bound is set to zero

ub1 = zeros(1, low_time);
ub2 = pmax*ones(1, high_time);
ub3 = cat(2, ub1, ub2);
ub4 = zeros(1, last_time);
ub5 = cat(2, ub3, ub4);
output = ub5(arrival:departure);
end


