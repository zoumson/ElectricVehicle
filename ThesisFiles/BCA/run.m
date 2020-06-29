


%% BCA Brute Charging Algorithm 
%  Only one electricity pricing pattern is used
%  Only perform charging, no discharge
%  Issue : same behavior, transformer overload 
clc
clear
close all

% Load data
tic
data = readmatrix('ev200.xls');

% Transformer maximum power

% 10 EV ---> tp  = 50;
% 500 EV ---> tp  = 2500;
tp  = 722;

% Time slot in term of minutes
minute = 5;
fmax = 8;

% SOC initial 
soci = data(:, 3);

% SOC final/desired  
socf = data(:, 4);

% Number of Electrical vehicle in station
ev = length(soci);

TOTAL_COST = 0;

final(ev) = struct();


% Maximum charging power for each electrical vehicle (kW)
pmax = 7;

% Each EV Battery capacity(kWh)
cap = 44;

tslot = minute/60;

% Simulation horizon 1 day --> 24h
ending = 24/tslot;
starting = 1;

% Initial Power limits
lb = zeros(1, ending);
ub = zeros(1, ending);

% Transform arrival time from hours to number of time slots
arival = data(:, 1)./tslot;

% First EV to get into the charging station
min_arr = min(arival);

% Transform departure time from hours to number of time slots
departure = data(:, 2)./tslot;

% Last EV to leave the charging station
max_dep = max(departure);


% Remaining Transformer maximum power over one day after each charging of
% EV
trans = tp.*ones(1, ending);

ptmax = 50;
plot_trans = trans;
plot_trans(1:min_arr -1) = ptmax;
plot_trans(max_dep +1:end) = ptmax;

% No inequalities constraint 
A = [];
b = [];

% TOU
low = 1.69;
high = 3.62;


% Period of low pricing electricity power
low_time = 8/tslot;

% Period of high pricing electricity power
high_time = 9/tslot; 

% Period of low pricing electricity power
last_time = 7/tslot;

TOTAL_POWER = zeros(starting, ending).';

% First come first serve 
[~, index ]  = sort(arival);


% Normal pricing pattern without any modification
M = normal_price(low, high, low_time, high_time, last_time);
writematrix(M.','TOU.xls');

satisfied = 0;
% Uncomment 
for i = 1: ev
    
    % Only use one modified pricing pattern 
    f = pattern1(low, high, low_time, high_time, last_time);
     
    % Reference pricing pattern
    f_normal = normal_price(low, high, low_time, high_time, last_time);
    
    Aeq = ones(1, ending);
    % SOC needed to satisfy all ev in the station
    beq = (socf(index(i)) - soci(index(i))).*cap./tslot;
  
    % Update maximum charging power due to transformer constraint
    [~, indexmax] = find (trans >= pmax);
    [~, indexnorm] = find (trans < pmax);
    
    % No overload, use  pmax for charging 
    ub(indexmax) = pmax;
    
    % Overload, use the ramaining power less than pmax for charging 
    ub(indexnorm) = trans(indexnorm);
    
    % Used to evaluate real cost, reference pricing pattern 
    
    % Time staying in the station
    section = arival(index(i)):departure(index(i));
    % lp constraints
    Aeq_c = Aeq(section);
    lb_c = lb(section);
    ub_c = ub(section);
    price = f_normal(section);
    
    
    % No charging before arrival and after departure
    ub(starting:arival(index(i))-1) = 0;
    ub(departure(index(i)) + 1:end) = 0;
    
    % Time in the station 
    duration = departure(index(i)) - arival(index(i));
    
    % check if there is enough time to charge ev to its desired SOC
    % Total power given during its stay if pmax was given every time slot
    possible = sum(ub);
    
    % short stay, desired SOC is changed, beq is what is the SOC needed  
    ispos = possible - beq;
    if ispos < 0 % Short stay, change desired soc
        beq = possible;
        
    else
        satisfied = satisfied + 1;
    end
    
    % Find SOC at departure time
    socfinal = beq.*tslot/cap + soci(index(i));
    
    % No charging before arrival and after departure
    f(starting:arival(index(i))-1) = fmax;
    f(departure(index(i)) + 1:end) = fmax;
    
    % Evalute charging cost using energy
    energy = tslot.*price;
    [ch, cost] = linprog(energy,A,b,Aeq_c,beq,lb_c,ub_c);
    
    % Total charging cost for the charging station
    TOTAL_COST = TOTAL_COST + cost;
    
    % Evalute charging power 
    [pow, fval] = linprog(f.*tslot,A,b,Aeq,beq,lb,ub);
    check_pow = isequal(sum(ch), sum(pow));
    
    % Total power consummed in the station
    TOTAL_POWER = TOTAL_POWER + pow;
    
    % Record  each ev power consumption and charging cost
    final(index(i)).power = pow;
    
    final(index(i)).cost = cost;
    
    % Residual Transformer power after charging EV i
    trans = trans - pow.';
% % Plot EV power
%     figure(index(i)) 
%     subplot(3, 1, 1)
%     
%    plot_price(f, fmax)
% 
%     subplot(3, 1, 2)
%     bar(pow, 'y')
%     title('Power(kW)')
%     set(gca,'FontSize',20);
%     subplot(3, 1, 3)
%     
%     plot_soc(soci(index(i)), -pow, cap, tslot)
%     
%     
%     %disp(['Figure ' num2str(i)])
%     title(['Initial SOC: ', num2str(100.*soci(index(i))), ...
%         '         Desired SOC : ', num2str(100.*socf(index(i))),...
%         '         Final SOC : ', num2str(100.*socfinal)], 'color', 'w')
%         
%   
%     f = [];
%     f_normal = [];
end
toc
% Plot transformer power vs total consumed power
figure(100)
%%trans_limit(plot_trans, TOTAL_POWER, ptmax)
plot_pow(-TOTAL_POWER, -tp);
C = [final(:).cost];
% Write result 
%writematrix(C,'g2vresult300_800.xls')
satisfied 
TOTAL_COST
