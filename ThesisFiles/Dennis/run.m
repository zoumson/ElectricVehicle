
close all;
clc;
clear;


% 200 evs cost = 1.2877e+04 new : 8.7013e+03--> 290.04 USD
% 400 evs cost = 2.5144e+04 new : 1.7227e+04--> 574.24 USD
% 500 evs cost = 3.1845e+04 new : 2.1911e+04--> 730.36 USD

fleet = 1;
ev_fleet = [200, 400, 500];
cc_fleet = [1000, 1900, 2500];
ev = ev_fleet(fleet);
cc = cc_fleet(fleet);
power_xlsx_name = strcat('ev_data_20190304_', num2str(ev),'.xlsx');
price = readmatrix('TOU.xls');
price = price.';

ev_pow_data = readmatrix(power_xlsx_name);

% sum column wise
ev_pow = sum(ev_pow_data, 1);
tslot = 5/60;
%  plot_power(ev_pow, cc);
 pp = tslot.*(-ev_pow_data).*price;

cost = sum(pp(:))/30
 
 