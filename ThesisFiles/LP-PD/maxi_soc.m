function output = maxi_soc(socmax, socini, cap, tslot)
%% Used to build SOC constraint
output = (socmax - socini)*cap/tslot;
end