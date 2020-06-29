function output = v2g_soc(prev_soc, pow, cap, tslot)
%% ESS providing V2G service sells only when price are high otherwise 
% upper bound is set to 

output = prev_soc - (tslot*pow)/cap;

end