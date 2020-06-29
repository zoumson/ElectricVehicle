function output = lb_v2g(pmin, arrival, departure,low_time,high_time, last_time)
%% ESS providing V2G service charges power only when price are low otherwise 
% During Low Price Lower Bound is set to pmin 
% During High Price Lower bound is set to zero
lb1 = pmin*ones(1, low_time);
lb2 = zeros(1, high_time);
lb3 = cat(2, lb1, lb2);
lb4 = pmin*ones(1, last_time);
lb5 = cat(2, lb3, lb4);
output = lb5(arrival:departure);
end