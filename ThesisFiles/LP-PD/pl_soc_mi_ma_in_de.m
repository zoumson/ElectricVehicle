function [socmin, socmax, socin, desired_soc]=pl_soc_mi_ma_in_de(ev)
%% random  SOC generation, namely socmin, socmax, socin, desired_soc
socin = unifrnd(0.31,0.4, 1, ev);
socmin = unifrnd(0.08,0.27, 1, ev);
socmax = unifrnd(0.9,1, 1, ev);
desired_soc = unifrnd(0.75,0.88, 1, ev);

end


