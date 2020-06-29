function output = mini_soc(socmin, socini, cap, tslot)
%% Used to build SOC constraint
output = (socmin - socini)*cap/tslot;
end
