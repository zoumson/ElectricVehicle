function y = utitlity_trans(trans_price, trans_pow, cost_ev, satisfied)

y = (trans_price*trans_pow/30).^2 +  cost_ev - satisfied.^5; 

end