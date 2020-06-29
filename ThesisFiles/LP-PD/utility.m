clc
clear
close all
%trans_pow_ncku = 650 kw;
trans_price = 223.6;
%% 10 EVs contract capacity
fleet_size_10 = 10;
trans_10 = [10, 20, 30, 40, 50, 60, 70];      
cost_10 = [479.3083, 471.0751,399.3599, 332.1850, 276.3416, 267.5622, 267.5622 ];
satisfied_10 = [8, 10, 10, 10, 10, 10, 10];

index_trans_10 = utitlity_trans(trans_price, trans_10, cost_10, satisfied_10);
utility_trans_10 = min_max_norm(index_trans_10);
index_ev_10= utitlity_ev(trans_price, trans_10, cost_10, satisfied_10);
utility_ev_10 = min_max_norm(index_ev_10);
utility_10 = 1./(utility_ev_10 + utility_trans_10);
utility_10 = min_max_norm(utility_10);
index_10 = find(utility_10 == max(utility_10));
index_10 = index_10(1);
contract_capacity_10 = trans_10(index_10);


%% 20 EVs contract capacity
fleet_size_20 = 20;
trans_20 = [20, 40, 60, 80, 100, 120, 140];     
cost_20 = [914.6767, 889.9405, 721.3739, 667.8388, 604.6948, 604.6948, 604.6948];
satisfied_20 = [15, 20, 20, 20, 20, 20, 20];
index_trans_20 = utitlity_trans(trans_price, trans_20, cost_20, satisfied_20);
utility_trans_20 = min_max_norm(index_trans_20);
index_ev_20= utitlity_ev(trans_price, trans_20, cost_20, satisfied_20);
utility_ev_20 = min_max_norm(index_ev_20);
utility_20 = 1./(utility_ev_20 + utility_trans_20);
utility_20 = min_max_norm(utility_20);
index_20 = find(utility_20 == max(utility_20));
index_20 = index_20(1);
contract_capacity_20 = trans_20(index_20);

%% 50 EVs contract capacity
fleet_size_50 = 50;
trans_50 = [50, 100, 150, 200, 250, 300, 350];      
cost_50 = [2.3949e+03, 2.1207e+03, 1.6246e+03, 1.3789e+03, 1.1281e+03, 1.1281e+03, 1.1281e+03];
satisfied_50 = [42, 50, 50, 50, 50, 50, 50];
index_trans_50 = utitlity_trans(trans_price, trans_50, cost_50, satisfied_50);
utility_trans_50 = min_max_norm(index_trans_50);
index_ev_50= utitlity_ev(trans_price, trans_50, cost_50, satisfied_50);
utility_ev_50 = min_max_norm(index_ev_50);
utility_50 = 1./(utility_ev_50 + utility_trans_50);
utility_50 = min_max_norm(utility_50);
index_50 = find(utility_50 == max(utility_50));
index_50 = index_50(1);
contract_capacity_50 = trans_50(index_50);



%% 100 EVs contract capacity
fleet_size_100 = 100;
trans_100 = [100, 200, 300, 400, 500, 600, 700];      
cost_100 = [4.8082e+03, 4.3690e+03, 3.4977e+03, 3.1379e+03, 2.9033e+03, 2.9033e+03, 2.9033e+03];
satisfied_100 = [80, 100, 100, 100, 100, 100, 100];
index_trans_100 = utitlity_trans(trans_price, trans_100, cost_100, satisfied_100);
utility_trans_100 = min_max_norm(index_trans_100);
index_ev_100= utitlity_ev(trans_price, trans_100, cost_100, satisfied_100);
utility_ev_100 = min_max_norm(index_ev_100);
utility_100 = 1./(utility_ev_100 + utility_trans_100);
utility_100 = min_max_norm(utility_100);
index_100 = find(utility_100 == max(utility_100));
index_100 = index_100(1);
contract_capacity_100 = trans_100(index_100);



%% 150 EVs contract capacity
fleet_size_150 = 150;
trans_150 = [450, 550, 650, 750, 850, 950, 1050];      
cost_150 = [4.8851e+03, 4.3930e+03, 3.9629e+03, 3.5765e+03, 3.4323e+03, 3.4323e+03, 3.4323e+03];
satisfied_150 = [150, 150, 150, 150, 150, 150, 150];
index_trans_150 = utitlity_trans(trans_price, trans_150, cost_150, satisfied_150);
utility_trans_150 = min_max_norm(index_trans_150);
index_ev_150= utitlity_ev(trans_price, trans_150, cost_150, satisfied_150);
utility_ev_150 = min_max_norm(index_ev_150);
utility_150 = 1./(utility_ev_150 + utility_trans_150);
utility_150 = min_max_norm(utility_150);
index_150 = find(utility_150 == max(utility_150));
index_150 = index_150(1);
contract_capacity_150 = trans_150(index_150);



%% 200 EVs contract capacity
fleet_size_200 = 200;
trans_200 = [200, 400, 600, 800, 1000, 1200, 1400];      
cost_200 = [9.7595e+03, 8.4332e+03, 6.8856e+03, 6.0936e+03, 5.5657e+03, 5.5280e+03, 5.5280e+03];
satisfied_200 = [175, 200, 200, 200, 200, 200, 200];
index_trans_200 = utitlity_trans(trans_price, trans_200, cost_200, satisfied_200);
utility_trans_200 = min_max_norm(index_trans_200);
index_ev_200= utitlity_ev(trans_price, trans_200, cost_200, satisfied_200);
utility_ev_200 = min_max_norm(index_ev_200);
utility_200 = 1./(utility_ev_200 + utility_trans_200);
utility_200 = min_max_norm(utility_200);
index_200 = find(utility_200 == max(utility_200));
index_200 = index_200(1);
contract_capacity_200 = trans_200(index_200);



%% 250 EVs contract capacity
fleet_size_250 = 250;
trans_250 = [550, 750, 950, 1150, 1350, 1550, 1750];      
cost_250 = [1.0045e+04, 8.6797e+03, 7.8134e+03, 7.0561e+03, 6.5866e+03, 6.5866e+03, 6.5866e+03];
satisfied_250 = [250, 250, 250, 250, 250, 250, 250];

index_trans_250 = utitlity_trans(trans_price, trans_250, cost_250, satisfied_250);
utility_trans_250 = min_max_norm(index_trans_250);
index_ev_250= utitlity_ev(trans_price, trans_250, cost_250, satisfied_250);
utility_ev_250 = min_max_norm(index_ev_250);
utility_250 = 1./(utility_ev_250 + utility_trans_250);
utility_250 = min_max_norm(utility_250);
index_250 = find(utility_250 == max(utility_250));
index_250 = index_250(1);
contract_capacity_250 = trans_250(index_250);



%% 300 EVs contract capacity
fleet_size_300 = 300;
trans_300 = [900, 1100, 1300, 1500, 1700, 1900, 2100];      
cost_300 = [1.0077e+04, 9.0144e+03, 8.4175e+03, 7.7705e+03, 7.5990e+03, 7.5990e+03, 7.5990e+03];
satisfied_300 = [300, 300, 300, 300, 300, 300, 300];

index_trans_300 = utitlity_trans(trans_price, trans_300, cost_300, satisfied_300);
utility_trans_300 = min_max_norm(index_trans_300);
index_ev_300= utitlity_ev(trans_price, trans_300, cost_300, satisfied_300);
utility_ev_300 = min_max_norm(index_ev_300);
utility_300 = 1./(utility_ev_300 + utility_trans_300);
utility_300 = min_max_norm(utility_300);
index_300 = find(utility_300 == max(utility_300));
index_300 = index_300(1);
contract_capacity_300 = trans_300(index_300);



%% 350 EVs contract capacity
fleet_size_350 = 350;
trans_350 = [1250, 1450, 1650, 1850, 2050, 2250, 2450];      
cost_350 = [1.1141e+04, 1.0447e+04, 9.6094e+03, 9.3857e+03, 9.3857e+03, 9.3857e+03, 9.3857e+03];
satisfied_350 = [350, 350, 350, 350, 350, 350, 350];

index_trans_350 = utitlity_trans(trans_price, trans_350, cost_350, satisfied_350);
utility_trans_350 = min_max_norm(index_trans_350);
index_ev_350= utitlity_ev(trans_price, trans_350, cost_350, satisfied_350);
utility_ev_350 = min_max_norm(index_ev_350);
utility_350 = 1./(utility_ev_350 + utility_trans_350);
utility_350 = min_max_norm(utility_350);
index_350 = find(utility_350 == max(utility_350));
index_350 = index_350(1);
contract_capacity_350 = trans_350(index_350);



%% 400 EVs contract capacity
fleet_size_400 = 400;
trans_400 = [1000, 1300, 1600, 1900, 2200, 2500, 2800];      
cost_400 = [1.4314e+04, 1.2283e+04, 1.0899e+04, 9.8508e+03, 9.4352e+03, 9.4352e+03, 9.4352e+03];
satisfied_400 = [400, 400, 400, 400, 400, 400, 400];

index_trans_400 = utitlity_trans(trans_price, trans_400, cost_400, satisfied_400);
utility_trans_400 = min_max_norm(index_trans_400);
index_ev_400= utitlity_ev(trans_price, trans_400, cost_400, satisfied_400);
utility_ev_400 = min_max_norm(index_ev_400);
utility_400 = 1./(utility_ev_400 + utility_trans_400);
utility_400 = min_max_norm(utility_400);
index_400 = find(utility_400 == max(utility_400));
index_400 = index_400(1);
contract_capacity_400 = trans_400(index_400);



%% 450 EVs contract capacity
fleet_size_450 = 450;
trans_450 = [750, 1150, 1550, 1950, 2350, 2750, 3150];      
cost_450 = [2.0574e+04, 1.6507e+04, 1.4159e+04, 1.2910e+04, 1.2298e+04,1.2298e+04, 1.2298e+04 ];
satisfied_450 = [450, 450, 450, 450, 450, 450, 450];

index_trans_450 = utitlity_trans(trans_price, trans_450, cost_450, satisfied_450);
utility_trans_450 = min_max_norm(index_trans_450);
index_ev_450= utitlity_ev(trans_price, trans_450, cost_450, satisfied_450);
utility_ev_450 = min_max_norm(index_ev_450);
utility_450 = 1./(utility_ev_450 + utility_trans_450);
utility_450 = min_max_norm(utility_450);
index_450 = find(utility_450 == max(utility_450));
index_450 = index_450(1);
contract_capacity_450 = trans_450(index_450);



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
contract_capacity = [contract_capacity_10, contract_capacity_20,...
                     contract_capacity_50, contract_capacity_100, ...
                     contract_capacity_150, contract_capacity_200,...
                     contract_capacity_250, contract_capacity_300, ...
                     contract_capacity_350, contract_capacity_400,...
                     contract_capacity_450, contract_capacity_500];
%% overall fleet size 
fleet_size = [fleet_size_10, fleet_size_20,...
                     fleet_size_50, fleet_size_100, ...
                     fleet_size_150, fleet_size_200,...
                     fleet_size_250, fleet_size_300, ...
                     fleet_size_350, fleet_size_400,...
                     fleet_size_450, fleet_size_500];    
  varNames = {'Fleet_Size','Contract_Capacity'};           
  fleet_size_contract_capacity = table(fleet_size.', contract_capacity.', 'VariableNames',varNames) 
  
                 
