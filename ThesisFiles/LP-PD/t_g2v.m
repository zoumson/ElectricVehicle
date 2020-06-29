function output = t_g2v(desired_soc, socmin, pmax, cap, tslot)
%% Time needed to charge EV from its minimum SOC to its desired SOC
o = (desired_soc-socmin)*cap/(pmax*tslot);
output = ceil(o);
end
