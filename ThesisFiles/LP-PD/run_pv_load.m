
%% Parking Lot Scheduling 
clear
clc
close all
% tic
format short 
rng('default') 
tic


%% Size, cost, time, contract capacity 
% 10 EVs cost = 441.0808, Time = 1.723351 s , trans = 50
% 20 EVs cost = 793.0680, Time = 2.880685 s, trans = 100
% 50 EVs cost = 1.8063e+03, Time = 8.803414 s, trans = 250
% 100 EVs cost = 3.8806e+03, Time = 15.788065 s, trans = 400
% 150 EVs cost = 5.4451e+03, Time = 23.356590 s, trans = 800
% 200 EVs cost = 7.1510e+03, Time = 30.355822 s, trans = 1000
% 250 EVs cost = 9.0239e+03, Time = 39.560727 s, trans = 1200
% 300 EVs cost = 1.1187e+04, Time = 47.970433 s, trans = 1400
% 350 EVs cost = 1.2651e+04, Time = 52.811259 s, trans = 1700
% 400 EVs cost = 1.4271e+04, Time = 61.615269 s, trans = 1900
% 450 EVs cost = 1.6563e+04, Time = 68.584228 s, trans = 2000
% 500 EVs cost = 1.8149e+04, Time = 72.739169 s, trans = 2500
% 
%     Fleet_Size    Contract_Capacity
%     __________    _________________
% 
%         10                50       
%         20                80       
%         50               200       
%        100               400       
%        150               750       
%        200               800       
%        250              1150       
%        300              1500       
%        350              1650       
%        400              1900       
%        450              1550       
%        500              1500 

%% Parking Lot Information

% Time slot
minute  = 5;
tslot = minute/60;

% Simulation horizon
ending = 24./tslot;

g2vV2gOrg2vOnlyName = ["g2v&&v2g", "g2v"];

v2gMarker = [1, 0];

 for v2gMarkerIndex = 1:size(v2gMarker, 2)
% for v2gMarkerIndex = 1:1
evNumber = [200, 400, 500];
contractCapacityNumber  = [833, 1677, 2133];
% % Load data
v2g = v2gMarker(v2gMarkerIndex);
v2gName = g2vV2gOrg2vOnlyName(v2gMarkerIndex);


for evNumberIndex = 1:size(evNumber, 2)
    
%  for evNumberIndex = 1:1
ev_num = evNumber(evNumberIndex);
transformer_power  = contractCapacityNumber(evNumberIndex);
readDataName = strcat('ev', num2str(ev_num), '.xls');
figDataName = strcat('power_', num2str(ev_num),'_ev_',v2gName, '.png');
data = readmatrix(readDataName);
% Transformer maximum power

% ev = 500, transformer_power  = 2133;
% ev = 400, transformer_power  = 1677;
% ev = 200, transformer_power  = 833;
% Maximum EV in the station 
evmax = ev_num;


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

% Total of EV in station
ev = length(arival);
desired_soc = final_soc;
% if stay time don't allow full charge, final soc is lesser than  desired

% Maximun discharging power for each EV(kW)
pmax_ev = 7;

% Maximun charging power for each EV(kW)
pmin_ev = -pmax_ev;

% Each EV battery maximum capacity (kWh)
cap_ev = 44;



% Transfomer maximum power 
trans = transformer_power.*ones(1, ending);

ptmax = transformer_power + 10;
plot_trans = trans;
plot_trans(1:min_arr -1) = ptmax;
plot_trans(max_dep +1:end) = ptmax;


% Simulation Horizon 
starting = 1;
ending = 24/tslot;
%% End of Parking Lot Information
%% Electricity Price
low = 1.69;
high = 3.62;


% Low electricity price periods
low_time = 8/tslot;

% High electricity price periods
high_time = 9/tslot; 

% Low electricity price periods
last_time = 7/tslot;

% reference price from the grid 
priceold = normal_price(low, high, low_time, high_time, last_time);

% 3 charging price patterns
pattern = [pattern1(low, high, low_time, high_time, last_time);...
    pattern2(low, high, low_time, high_time, last_time);...
    pattern3(low, high, low_time, high_time, last_time)];

[num_pattern, ~] = size(pattern);
%% End of Electricity Price


% Charging Priority
rankch = priority_charge(socini, desired_soc,arival, departure, pmin_ev,...
                                                                tslot, ev);
% Willingness to join V2G(Battery Degradation Cost)
% High BDC unwillingness 
BDC_min = 0;
BDC_max = 10;
BDC = unifrnd(BDC_min,BDC_max, 1, ev);
%% End of EVs Information
%% ESS Information
ess = 1;
pmax_ess = 12.5;% Maximum Discharging Power 12.5
pmin_ess = -12.5;% Minimum Charging Power
socmin_ess = 0.2;% Minimum SOC
socmax_ess =0.8;% Maximum SOC
socini_ess = 0.3;% Initial SOC
cap_ess = 50;% ESS Total cap_evacity in kWh set to 50
%% End of ESS Information

%% Final EV and ESS scheduled Power
final(ev) = struct();
total_ev_pow = zeros(ending, 1);

num_g2v_only = 0;
num_g2v_v2g = 0;
satisfied  = 0;
%% Entire  EVS and ESS
% for i = 1:ev+ess
for i = 1:ev+ess  % Run for ev and ESS
%  for i = 1:10
    if i ~= ev+ess % EVs first 
      % lower bound for charging 
      lower_v2g_only = zeros(1, ending-starting);
        for k = starting : ending
             % Check contract capacity 
   
             if (total_ev_pow(k)) >= 0
                 
                 lower_v2g_only(k) = pmin_ev ;
             else
                 surplus = transformer_power-abs(total_ev_pow(k));
                 if( surplus >= 0 && surplus >= -pmin_ev)
                     lower_v2g_only(k) = pmin_ev ;
                 elseif(surplus >= 0 && surplus < -pmin_ev)
                     lower_v2g_only(k) = -surplus ;
                 else
                     lower_v2g_only(k) = 0 ;
                 end
%              if (  transformer_power - abs(total_ev_pow(k)) >= -pmin_ev)
%                       lower_v2g_only(k) = pmin_ev ;           
%              elseif (  abs(total_ev_pow(k)) - transformer_power >= 0 )
%                     
%                     lower_v2g_only(k) = 0;
%              elseif (transformer_power - abs(total_ev_pow(k)) < -pmin_ev...
%                      && (transformer_power - abs(total_ev_pow(k)) >= 0)) 
%                      lower_v2g_only(k) = -1*(total_ev_pow(k)+transformer_power);
             end 
            
        end% end of for loop  
    lb_v2g_only = lower_v2g_only(arival(i):departure(i));    
    power_need = sum(lb_v2g_only(:));
    duration = departure(i) - arival(i);
    soc_gain = (-1*power_need*tslot)/cap_ev;    
    soc_need =     desired_soc(i)-socini(i);
    v2g_g2v_possible_cond_1 = soc_need <= soc_gain;
    avg_charging_pow = power_need/duration;
    
%     Time necessary to fill ev in v2g g2v situation
    
    t_g2v_in_v2g_g2v = t_g2v(desired_soc(i), socmin(i), -avg_charging_pow,...
    cap_ev, tslot);
    v2g_g2v_possible_cond_2 = t_g2v_in_v2g_g2v <= duration;
    v2g_g2v_possible = v2g_g2v_possible_cond_1 & v2g_g2v_possible_cond_2;
%     time_to_full =cap_ev*(desired_soc(i)-socini(i))/(pfull);
%     v2g_g2v_possible = t_g2v_in_v2g_g2v >= duration;
    
    or_price_old_sec = priceold(arival(i):departure(i));

    constant_price_checker =  constant_price(or_price_old_sec, low, high);

    %% First Option G2V

%
if((constant_price_checker)|(~v2g_g2v_possible))
         
%           if 1 
        num_g2v_only = num_g2v_only +1;
        if(~v2g_g2v_possible_cond_1)
            final_soc(i) = socini(i) - (avg_charging_pow*tslot*duration)/cap_ev;
        else
            satisfied = satisfied + 1;
        end
        
        priority_id = (find(rankch == i));
        pattern_id = mod(priority_id,num_pattern);
        if pattern_id == 0
           pattern_id =  num_pattern;
        end
        pricech = pattern(pattern_id, :);
        price_old_sec =priceold(arival(i):departure(i));
        price_ch_sec = pricech(arival(i):departure(i));
 
        A = [];
        b = [];
        l = length(price_ch_sec);
        Aeq =  ones(1,l);
        beq = -cap_ev*(final_soc(i)-socini(i))/tslot;
        upper = zeros(1, ending-starting);
        ub = upper(arival(i):departure(i));
        
        if ((~v2g_g2v_possible_cond_1)|(constant_price_checker))
           [power, cost] = linprog(-1*price_old_sec*tslot,A,b,Aeq,beq,lb_v2g_only,ub);
        else
            [~, cost] = linprog(-1*price_old_sec*tslot,A,b,Aeq,beq,lb_v2g_only,ub);
            [power, ~] = linprog(-1*price_ch_sec*tslot,A,b,Aeq,beq,lb_v2g_only,ub);
        end

      

        final(i).before = zeros(arival(i)-starting, 1);
        final(i).after = zeros(ending -departure(i), 1);
        final(i).now = power;
        final(i).def = [final(i).before; final(i).now; final(i).after ];
        final(i).cost = cost;
%         % Uncomment to display graph
% 
%         h = figure(i);
% 
%         subplot(3, 1, 1)
%         plot_price(price_old_sec, cost, 'G2V Option Only')
%         hold on 
% 
%         plot_price(price_ch_sec, cost,...
%             'G2V Option Only[Constant Price or Short Stay Time]')
% 
%         grid on
%         grid minor
%         set(gca,'FontSize',15)
%         set(get(h,'CurrentAxes'),'GridAlpha',0.4,'MinorGridAlpha',0.7);
%         whitebg('k');
%         legend({'Original Price','Modified Price'}, 'FontSize', 15)
%         subplot(3, 1, 2)
% 
%         plot_pow(power)
%         title(['EV Power From entering (',num2str((tslot)*arival(i)),...
%             'h) to leaving (',num2str(tslot*departure(i)),...
%             'h) the Parking Lot. [ Duration = ',...
%             num2str(tslot*(departure(i)-arival(i))), 'h]'],...
%             'color', 'y', 'FontSize', 20)
%         grid on
%         grid minor
%         set(gca,'FontSize',15)
%         set(get(h,'CurrentAxes'),'GridAlpha',0.4,'MinorGridAlpha',0.7);
%         whitebg('k');
%         
%         subplot(3, 1, 3)
%         
%         plot_soc(socini(i), power, cap_ev, tslot);
% 
%         title(['Initial SOC = ',num2str(100*socini(i)),...
%             '%  Desired SOC  = ',num2str(100*desired_soc(i)),...
%             '%  Final SOC  = ',num2str(100*final_soc(i)),...
%             '%  Minimum SOC = ',num2str(100*socmin(i)),...
%             '%  Maximum SOC  = ',num2str(100*socmax(i)), '%'],...
%             'color', 'y')
% 
%         grid on
%         grid minor
%         set(gca,'FontSize',15)
%         set(get(h,'CurrentAxes'),'GridAlpha',0.4,'MinorGridAlpha',0.2);
%         whitebg('k');
%         h.InvertHardcopy = 'off';
%          set(h,'PaperPositionMode','auto')
%         saveas(h,'GrayBackground.png')
% %         % End of comment
     else

        %% G2V or G2V && V2G based on cost 
        priority_id = (find(rankch == i));
        pattern_id = mod(priority_id,num_pattern);      
        if pattern_id == 0
           pattern_id =  num_pattern;
        end
        pricenew = pattern(pattern_id, :);
        f = pricenew(arival(i):departure(i));
        old_price = priceold(arival(i):departure(i));
        fch = f;
        [fv2g, ~, final_soc(i)] = price_split(f, t_g2v_in_v2g_g2v, ...
            socini(i), final_soc(i), -avg_charging_pow, tslot, cap_ev);

        [ffv2g, ffg2v, final_soc(i)] = price_split(old_price, ...
            t_g2v_in_v2g_g2v, socini(i),final_soc(i),...
                                                -avg_charging_pow, tslot, cap_ev);

        [~, fg2v, final_soc(i)] = price_split(fch, t_g2v_in_v2g_g2v, ...
            socini(i), final_soc(i), -avg_charging_pow, tslot, cap_ev);

        ftol = [fv2g , fg2v];
        l = length(fv2g);
        ll = length(fg2v);

        %% V2G and G2V
        A = A_constraint(l);
        lp = mini_soc(socmin(i), socini(i), cap_ev, tslot);
        up = maxi_soc(socmax(i), socini(i), cap_ev, tslot);
        b = b_constraint(l, up, lp);
        
        upper = zeros(1, ending-starting);
%         lower = zeros(1, ending-starting);  

            for k = starting : ending
                if(k<=low_time || k>=low_time+high_time)% charging time 
                upper(k) = 0;% no discharge 
                else% discharge time 
                upper(k) = pmax_ev;
           
                end 
            end% end of for loop

            lb = lower_v2g_only(arival(i):arival(i)+l);
            ub = upper(arival(i):arival(i)+l);
        Aeq = [];
        beq = [];
        % Like ESS
        [powv2g, ~] = linprog(-1*fv2g*tslot,A,b,Aeq,beq,lb,ub);

        [~, profit_v2g_g2v] = linprog(-1*ffv2g*tslot,A,b,Aeq,beq,lb,ub);
        % profit is originally negative showing earning money
        % for calculation profit set to positive
        profit_v2g_g2v = -profit_v2g_g2v;
        %% G2V
        powv2g = powv2g(1:l);
        soc_start_g2v = soc_end_v2g(socini(i), powv2g, cap_ev, tslot);
        Ach = [];
        bch = [];
        needed_soc = soc_start_g2v - final_soc(i);

%         lot = zeros(1, ending-starting);
        ut = zeros(1, ending-starting);

            for k = starting : ending
                if(needed_soc <= 0)
                    ut(k) = 0;
                else
                    ut(k) = pmax_ev ;
                end
            end

%            lbch = lot(arival(i)+l:departure(i));
           ubch = ut(arival(i)+l:departure(i));
           lbch = lower_v2g_only(arival(i)+l:departure(i));
        Aeqch = ones(1,ll);
        beqch = cap_ev*(needed_soc)/tslot;
        [powg2v, ~] = linprog(-1*fg2v*tslot,Ach,bch,Aeqch,beqch,lbch,ubch);
        [~, costg2v] = linprog(-1*ffg2v*tslot,Ach,bch,Aeqch,beqch,...
                                                                lbch,ubch);
        cost_v2g_g2v = costg2v - profit_v2g_g2v;
        evpow_v2g_g2v = final_pow(powv2g, powg2v);

        %% G2V Only Option 

        if(~v2g_g2v_possible_cond_1)
            final_soc(i) = socini(i) - (avg_charging_pow*tslot*duration)/cap_ev;
        end
        
        priority_id = (find(rankch == i));
        pattern_id = mod(priority_id,num_pattern);
        if pattern_id == 0
           pattern_id =  num_pattern;
        end

        pricech = pattern(pattern_id, :);
        price_g2v_only = pricech(arival(i):departure(i)); % only for plotting
        price_old_sec =priceold(arival(i):departure(i));
        price_ch_sec = pricech(arival(i):departure(i));
 
        A = [];
        b = [];
        l = length(price_ch_sec);
        Aeq =  ones(1,l);
        beq = -cap_ev*(final_soc(i)-socini(i))/tslot;
        upper = zeros(1, ending-starting);
        ub = upper(arival(i):departure(i));
        
        if ((~v2g_g2v_possible_cond_1)|(constant_price_checker))
           [pow_g2v_only, cost_g2v_only] = linprog(-1*price_old_sec*tslot,A,b,Aeq,beq,lb_v2g_only,ub);
        else
            [~, cost_g2v_only] = linprog(-1*price_old_sec*tslot,A,b,Aeq,beq,lb_v2g_only,ub);
            [pow_g2v_only, ~] = linprog(-1*price_ch_sec*tslot,A,b,Aeq,beq,lb_v2g_only,ub);
        end




        if(isempty(cost_v2g_g2v))
        G2V_V2G_CONDITION = 1;    
%         elseif (cost_v2g_g2v - BDC(i) <=0)
%         G2V_V2G_CONDITION = 1;
        else
%             G2V_V2G_CONDITION = cost_g2v_only  <= cost_v2g_g2v - BDC(i);
            G2V_V2G_CONDITION = cost_g2v_only  <= cost_v2g_g2v;
        end
        % Uncomment to able v2g and g2v
        
        % no v2g will run
           if (~v2g) | G2V_V2G_CONDITION
       

        % Replace condition (G2V_V2G_CONDITION) with if(1) to disactivate 
        % V2G
            %if (1)
            satisfied = satisfied + 1;
            num_g2v_only = num_g2v_only +1;
            final(i).before = zeros(arival(i)-starting, 1);
            final(i).after = zeros(ending -departure(i), 1);
            final(i).now= pow_g2v_only;
            final(i).def = [final(i).before;final(i).now;final(i).after];
            final(i).cost = cost_g2v_only;
%             % Uncomment to display graph
%             h = figure(i);
%             subplot(3, 1, 1)
%             plot_price(old_price, cost_g2v_only, 'G2V Option Only')
%             hold on 
% 
%             plot_price(price_g2v_only, cost_g2v_only, 'G2V Option Only')
% 
%             grid on
%             grid minor
%             set(gca,'FontSize',15)
%             set(get(h,'CurrentAxes'),'GridAlpha',0.4,'MinorGridAlpha',0.7);
%             whitebg('k');
%             legend({'Original Price','Modified Price'}, 'FontSize', 15)
%             subplot(3, 1, 2)
% 
%             plot_pow(pow_g2v_only)
%             title(['EV Power From entering (',num2str(tslot*arival(i)),...
%                 'h) to leaving (',num2str(tslot*departure(i)),...
%                 'h) the Parking Lot. [ Duration = ',...
%                 num2str(tslot*(departure(i)-arival(i))),'h]'],...
%                 'color','y','FontSize', 20)
%             grid on
%             grid minor
%             set(gca,'FontSize',15)
%             set(get(h,'CurrentAxes'),'GridAlpha',0.4,'MinorGridAlpha',0.7);
%             whitebg('k');
%             subplot(3, 1, 3)
%             plot_soc(socini(i), pow_g2v_only, cap_ev, tslot);
% 
%             title(['Initial SOC = ',num2str(100*socini(i)),...
%                 '%  Desired SOC  = ',num2str(100*desired_soc(i)),...
%                 '%  Final SOC  = ',num2str(100*final_soc(i)),...
%                 '%  Minimum SOC = ',num2str(100*socmin(i)), ...
%                 '%  Maximum SOC  = ',num2str(100*socmax(i)), '%'],...
%                                                             'color','y')
% 
%             grid on
%             grid minor
%             set(gca,'FontSize',15)
%             set(get(h,'CurrentAxes'),'GridAlpha',0.4,'MinorGridAlpha',0.2);
%             whitebg('k');
%             % End of comment  
            
        else
            if(v2g_g2v_possible_cond_1)
            satisfied = satisfied + 1;
            end
            num_g2v_v2g = num_g2v_v2g +1;
            final(i).before = zeros(arival(i)-starting, 1);
            final(i).after = zeros(ending -departure(i), 1);
            final(i).now = evpow_v2g_g2v;
            final(i).def = [final(i).before;final(i).now;final(i).after];
            final(i).cost = cost_v2g_g2v;
%             % Uncomment to display graph
%             h = figure(i);
% 
%             subplot(3, 1, 1)
%             plot_price(old_price, cost_v2g_g2v, 'V2G && G2V Option')
%             hold on 
%             plot_price(ftol, cost_v2g_g2v, 'V2G && G2V Option')
% 
%             grid on
%             grid minor
%             set(gca,'FontSize',25)
%             set(get(h,'CurrentAxes'),'GridAlpha',0.4,'MinorGridAlpha',0.7);
%             whitebg('k');
%             legend({'Original Price','Modified Price'}, 'FontSize', 15)
%             subplot(3, 1, 2)
% 
%             plot_pow(evpow_v2g_g2v)
%             title(['EV Power From entering (',num2str(tslot*arival(i)),...
%                 'h) to leaving (',num2str(tslot*departure(i)),...
%                 'h) the Parking Lot. [ Duration = ',...
%                 num2str(tslot*(departure(i)-arival(i))), 'h]'],...
%                 'color', 'y', 'FontSize', 20)
%             grid on
%             grid minor
%             set(gca,'FontSize',15)
%             set(get(h,'CurrentAxes'),'GridAlpha',0.4,'MinorGridAlpha',0.7);
%             whitebg('k');
%             subplot(3, 1, 3)
%             plot_soc(socini(i), evpow_v2g_g2v, cap_ev, tslot);
% 
%             title(['Initial SOC = ',num2str(100*socini(i))...
%                 ,'%  Desired SOC  = ',num2str(100*desired_soc(i)),...
%                 '%  Final SOC  = ',num2str(100*final_soc(i)),...
%                 '%  Minimum SOC = ',num2str(100*socmin(i)),...
%                 '%  Maximum SOC  = ',num2str(100*socmax(i)), '%'],...
%                                                             'color', 'y')
% 
%             grid on
%             grid minor
%             set(gca,'FontSize',15)
%             set(get(h,'CurrentAxes'),'GridAlpha',0.4,'MinorGridAlpha',0.2);
%             whitebg('k');
% 
%             % end of comment 

        end% end of v2g-g2v v2g only 

     end  % end constant_price or v2g-g2v not possible
   
     toc
%     if i == 1
%     else
%         total_ev_pow = total_ev_pow + final(i-1).def;
%     end
%     
    total_ev_pow = total_ev_pow + final(i).def;
    
    %% ESS starts here
    else
%         
%      %% Put ESS here      
%     %% Setting linear Programming Parameters A, b, lb, ub, Aeq, beq
%     pricenew = new_price(low, high, low_time, high_time, last_time);
%     l = length(pricenew);
%     A = A_constraint(l);
%     lp = mini_soc(socmin_ess, socini_ess, cap_ess, tslot);
%     up = maxi_soc(socmax_ess, socini_ess, cap_ess, tslot);
%     b = b_constraint(l, up, lp);
%     
%     %% ESS Charging feasibility
%     % Remaining power to be given to ESS after EVS Scheduling
%     ness = transformer_power*ones(ending - starting+1, 1)+total_ev_pow;
%     ness = -ness;   
%     lb_ess = lb_v2g(pmin_ess, starting, ending,low_time,high_time, last_time);
%     for j = 1:l
%         if ness(j)>=0
%             lb_ess(j) = 0;
%         elseif lb_ess(j) < ness(j)
%             lb_ess(j) = ness(j);
%             
%         else
%             lb_ess(j) = pmin_ess;
%         end                  
%     end
%     %% End of ESS Charging feasibility
%     %% ESS Power Sale
%     ub_ess = ub_v2g(pmax_ess, starting, ending,low_time,high_time, last_time);
%     %% End of ESS Power Sale
%     Aeq = [];
%     beq = [];
%     
%     % ESS Charging and Discharging is set as earlier as possible, using
%     % pricenew, which does not impact on real cost
%      pricenew = new_price(low, high, low_time, high_time, last_time);
%     [pow_ess, ~] = linprog(-1*pricenew*tslot,A,b,Aeq,beq,lb_ess,ub_ess);
%     % Real Cost is found from original price
%     [~, realcost_ess] = linprog(-1*priceold*tslot,A,b,Aeq,beq,lb_ess,ub_ess);
%   % Uncomment to display graph ess
%     h = figure(i);
%     subplot(3, 1, 1)
%     plot_price(priceold, realcost_ess, 'E2G && G2E Option')
%     set(gca,'FontSize',20)
% 
%     hold on 
%     plot_price(pricenew, realcost_ess, 'E2G && G2E Option')
%     legend({'Original Price','Modified Price'}, 'FontSize', 15)
%     set(gca,'FontSize',20)
%     grid on
%     set(get(h,'CurrentAxes'),'GridAlpha',0.8);
% 
%     subplot(3, 1, 2)
%     plot_pow(pow_ess)
%     title('ESS Power', 'Color', 'y','FontSize', 20)
%     set(gca,'FontSize',20)
%     grid on
%     grid minor
%     set(get(h,'CurrentAxes'),'GridAlpha',0,'MinorGridAlpha',0.8);
% 
%     subplot(3, 1, 3)
%     plot_soc(socini_ess, pow_ess, cap_ess, tslot);
%     title(['\color{red}ESS SOC      ',...
%         '\color{yellow}Initial SOC = ',num2str(100*socini_ess),...
%         '%  Minimum SOC = ',num2str(100*socmin_ess), ...
%         '%  Maximum SOC  = ',num2str(100*socmax_ess), '%'])
%     set(gca,'FontSize',20)
%     set(get(h,'CurrentAxes'),'GridAlpha',0.8);
%     grid on
% 
%     whitebg('k');
% % Uncomment to display graph
     end
     %% End of  ess
end
%% End of PL 

%% Plotting Results 
Total_Cost = sum([final(:).cost]);
% uncomment if not running for different fleet size
clearvars final

% figure(100)
%trans_limit(plot_trans, -total_ev_pow, ptmax)
% Plot power vs transformer max power 
 
 plotpow(total_ev_pow, transformer_power, figDataName, v2g)
% C = [final(:).cost];
% writematrix(C,'v2gresult50_250.xls');
% realcost_ess 
% satisfied 
% Total_Cost

end% running for different fleetsize for total charging power 

end% running for ever v2g&&g2v or g2v