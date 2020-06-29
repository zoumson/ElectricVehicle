clc
clear
close all
% Load data
data = readmatrix('ev10.xls');

tslot = 1;

% Maximum EV in the station 
evmax = 10;

% Arrival time from hours to number of time slots
arival = data(:, 1)./tslot;


arrival_max = max(arival);

% First EV getting into the station
min_arr = min(arival);

% Departure time from hours to number of time slots
departure = data(:, 2)./tslot;

departure_min = min(departure);

% Last EV leaving  the station
max_dep = max(departure);

% Initial SOC
socini = data(:, 3);

% Final/Desired SOC
final_soc = data(:, 4);

% SOC constraints
socmin = data(:, 5);
socmax = data(:, 6);