index_trans_given = utitlity_trans(trans_price, trans_given, cost_given, satisfied_given);
utility_trans_given = min_max_norm(index_trans_given);
index_ev_given= utitlity_ev(trans_price, trans_given, cost_given, satisfied_given);
utility_ev_given = min_max_norm(index_ev_given);
utility_given = 1./(utility_ev_given + utility_trans_given);
utility_given = min_max_norm(utility_given);
index_given = find(utility_given == max(utility_given));
index_given = index_given(1);
contract_capacity_given = trans_given(index_given);