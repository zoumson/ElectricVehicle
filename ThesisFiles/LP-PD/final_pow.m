function output = final_pow(v2g, g2v)
% Used to put V2G && G2V Power together
% First time slot EV is consider as ESS, Power is v2g
% Second time EV is just charging, Power is g2v
output = cat(1, v2g, g2v);
end




