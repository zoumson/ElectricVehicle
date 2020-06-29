function y = utitlity_ev(trans_price, trans_pow, cost_ev, satisfied)

y = trans_price*trans_pow/30 +  cost_ev.^2 - satisfied.^3; 

end