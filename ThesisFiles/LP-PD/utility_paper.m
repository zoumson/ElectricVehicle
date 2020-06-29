clc
clear
close all
%trans_pow_ncku = 650 kw;
trans_price = 223.6;
%% 200 EVs contract capacity

fleet_size_200 = 10;
trans_200 = [10, 20, 30, 40, 50, 60, 70];      
cost_200 = [479.3083, 471.0751,399.3599, 332.1850, 276.3416, 267.5622, 267.5622 ];
satisfied_200 = [8, 10, 10, 10, 10, 10, 10];

index_trans_200 = utitlity_trans(trans_price, trans_200, cost_200, satisfied_200);
utility_trans_200 = min_max_norm(index_trans_200);
index_ev_200= utitlity_ev(trans_price, trans_200, cost_200, satisfied_200);
utility_ev_200 = min_max_norm(index_ev_200);
utility_200 = 1./(utility_ev_200 + utility_trans_200);
utility_200 = min_max_norm(utility_200);
index_200 = find(utility_200 == max(utility_200));
index_200 = index_200(1);
contract_capacity_200 = trans_200(index_200);

%% 400 EVs contract capacity
fleet_size_400 = 10;
trans_400 = [10, 20, 30, 40, 50, 60, 70];      
cost_400 = [479.3083, 471.0751,399.3599, 332.1850, 276.3416, 267.5622, 267.5622 ];
satisfied_400 = [8, 10, 10, 10, 10, 10, 10];

index_trans_400 = utitlity_trans(trans_price, trans_400, cost_400, satisfied_400);
utility_trans_400 = min_max_norm(index_trans_400);
index_ev_400= utitlity_ev(trans_price, trans_400, cost_400, satisfied_400);
utility_ev_400 = min_max_norm(index_ev_400);
utility_400 = 1./(utility_ev_400 + utility_trans_400);
utility_400 = min_max_norm(utility_400);
index_400 = find(utility_400 == max(utility_400));
index_400 = index_400(1);
contract_capacity_400 = trans_400(index_400);

%% 500 EVs contract capacity
fleet_size_500 = 500;
trans_500 = [500, 1000, 1500, 2000, 2500, 3000, 3500];      
% cost_500 = [2.4436e+04, 2.0448e+04, 1.6800e+04, 1.4785e+04, 1.3529e+04, 1.3529e+04, 1.3529e+04];
% satisfied_500 = [444, 500, 500, 500, 500, 500, 500];

cost_500 = [1.7765e+04, 1.1833e+04, 8.7082e+03, 6.5395e+03,...
    6.2602e+03, 6.2602e+03, 6.2602e+03];
satisfied_500 = [500, 500, 500, 500, 500, 500, 500];

index_trans_500 = utitlity_trans(trans_price, trans_500, cost_500, satisfied_500);
utility_trans_500 = min_max_norm(index_trans_500);
index_ev_500= utitlity_ev(trans_price, trans_500, cost_500, satisfied_500);
utility_ev_500 = min_max_norm(index_ev_500);
utility_500 = 1./(utility_ev_500 + utility_trans_500);
utility_500 = min_max_norm(utility_500);
index_500 = find(utility_500 == max(utility_500));
index_500 = index_500(1);
contract_capacity_500 = trans_500(index_500);

%% overall contract capacity
contract_capacity = [contract_capacity_200,contract_capacity_400,...
                     contract_capacity_500];
%% overall fleet size 
fleet_size = [fleet_size_200,fleet_size_400,fleet_size_500];    
  varNames = {'Fleet_Size','Contract_Capacity'};           
  fleet_size_contract_capacity = table(fleet_size.', contract_capacity.', 'VariableNames',varNames) 


