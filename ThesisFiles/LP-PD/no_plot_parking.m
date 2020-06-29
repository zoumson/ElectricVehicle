
%% Parking Lot Scheduling 
clear
clc
close all
tic
format short 
rng('default') 
%% Parking Lot Information
transformer_power = 3000;
evmax = 500;
default = transformer_power/evmax;
tslot = 5/60;
starting = 1;
ending = 24/tslot;
%% End of Parking Lot Information
%% Electricity Price
low = 1.69;
high = 3.62;
low_time = 7.5/tslot;
high_time = 15/tslot; 
last_time = 1.5/tslot;
priceold = normal_price(low, high, low_time, high_time, last_time);
pattern = [pattern1(low, high, low_time, high_time, last_time);...
    pattern2(low, high, low_time, high_time, last_time);...
    pattern3(low, high, low_time, high_time, last_time)];

[num_pattern, ~] = size(pattern);
%% End of Electricity Price
%% EVs Information
ev = 5;
armin_ev = 1;
armax_ev = 9;
arival  = t_arrival(armin_ev, armax_ev,tslot, ev );
arrival_max = max(arival);
depmin_ev = 15;
depmax_ev = 19;
departure = t_departure(depmin_ev, depmax_ev,tslot, ev );
departure_min = min(departure);
pmax_ev = 7;
pmin_ev = -pmax_ev;
cap_ev = 44;
[socmin, socmax, socini, final_soc]=pl_soc_mi_ma_in_de(ev);
desired_soc = final_soc;
% Priority
rankch = priority_charge(socini, desired_soc,arival, departure, pmin_ev,...
                                                                tslot, ev);
% Willingness to join V2G(Battery Degradation Cost)
BDC_min = 0;
BDC_max = 10;
BDC = unifrnd(BDC_min,BDC_max, 1, ev);
%% End of EVs Information
%% ESS Information
ess = 1;
pmax_ess = 15;% Maximum Discharging Power
pmin_ess = -15;% Minimum Charging Power
socmin_ess = 0.2;% Minimum SOC
socmax_ess =0.8;% Maximum SOC
socini_ess = 0.5;% Initial SOC
cap_ess =60;% ESS Total cap_evacity in kWh
%% End of ESS Information
%% IF Many EVs in PL use default power
sharepow = transformer_power < pmax_ev*ev;
if sharepow
    pfull = default;
else
    pfull = pmax_ev;
end

%% Final EV and ESS scheduled Power
final(ev) = struct();
total_ev_pow = 0;

num_g2v_only = 0;
num_g2v_v2g = 0;

%% Entire  EVS and ESS
for i = 1:ev+ess
    if i ~= ev+ess
    % Time necessary to fill ev in v2g g2v situation
    duration = departure(i) - arival(i);
    t_g2v_in_v2g_g2v = t_g2v(desired_soc(i), socmin(i), default, cap_ev,...
                                                                    tslot);
    time_to_full = cap_ev*(final_soc(i)-socini(i))/(pfull*tslot);
    v2g_g2v_possibl = t_g2v_in_v2g_g2v >= duration;
    
    or_price_old_sec =priceold(arival(i):departure(i));

    constant_price_checker =  constant_price(or_price_old_sec, low, high);

    %% First Option G2V

     if(duration < time_to_full||constant_price_checker||v2g_g2v_possibl)
        num_g2v_only = num_g2v_only +1;
        if(duration < time_to_full)
            final_soc(i) = socini(i) + pfull*tslot*duration/cap_ev;
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
        lower = zeros(1, ending-starting);
        for k = starting : ending
            if(((k<=departure_min && k>=arrival_max)&&(sharepow))...
                    ||((constant_price_checker)&&(sharepow)))
                lower(k) = -default;
            else
                lower(k) = pmin_ev ;
            end
        end
        lb = lower(arival(i):departure(i));
        ub = upper(arival(i):departure(i));
        if ((duration < time_to_full)||constant_price_checker)
           [power, cost] = linprog(-1*price_old_sec*tslot,A,b,Aeq,beq,lb,ub);
        else
            [~, cost] = linprog(-1*price_old_sec*tslot,A,b,Aeq,beq,lb,ub);
            [power, ~] = linprog(-1*price_ch_sec*tslot,A,b,Aeq,beq,lb,ub);
        end

        final(i).before = zeros(arival(i)-starting, 1);
        final(i).after = zeros(ending -departure(i), 1);
        final(i).now = power;
        final(i).def = [final(i).before; final(i).now; final(i).after ];

     else

        %% Second Option:
        % -G2V only or 
        % -G2V && V2G 
        % -Why? Based on cost difference between the two
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
            socini(i), final_soc(i), default, tslot, cap_ev);

        [ffv2g, ffg2v, final_soc(i)] = price_split(old_price, ...
            t_g2v_in_v2g_g2v, socini(i), final_soc(i),...
                                                default, tslot, cap_ev);

        [~, fg2v, final_soc(i)] = price_split(fch, t_g2v_in_v2g_g2v, ...
            socini(i), final_soc(i), default, tslot, cap_ev);

        ftol = [fv2g , fg2v];
        l = length(fv2g);
        ll = length(fg2v);

        %% V2G and G2V
        A = A_constraint(l);
        lp = mini_soc(socmin(i), socini(i), cap_ev, tslot);
        up = maxi_soc(socmax(i), socini(i), cap_ev, tslot);
        b = b_constraint(l, up, lp);
        
        upper = zeros(1, ending-starting);
        lower = zeros(1, ending-starting);  

            for k = starting : ending
                if(k<=low_time || k>=low_time+high_time)
                lower(k) = pmin_ev ;
                upper(k) = 0;
                    if((k<=departure_min && k>=arrival_max) && sharepow)
                    lower(k) = -default;
                    end

                else
                lower(k) = 0 ;
                upper(k) = pmax_ev;
                    if((k<=departure_min && k>=arrival_max) && sharepow)
                    upper(k) = default;
                    end
                end 
            end

            lb = lower(arival(i):arival(i)+l);
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

        
        lot = zeros(1, ending-starting);
        ut = zeros(1, ending-starting);
  
            for k = starting : ending
                if(needed_soc <= 0)
                    lot(k) = pmin_ev ;
                    ut(k) = 0;
                    if((k<=departure_min && k>=arrival_max) && sharepow)
                        lot(k) = -default;
                    end
                else
                    ut(k) = pmax_ev ;
                    lot(k) = 0;
                    if((k<=departure_min && k>=arrival_max) && sharepow)
                        ut(k) = default;
                    end
                end
            end

           lbch = lot(arival(i)+l:departure(i));
           ubch = ut(arival(i)+l:departure(i));

        Aeqch = ones(1,ll);
        beqch = cap_ev*(needed_soc)/tslot;
        [powg2v, ~] = linprog(-1*fg2v*tslot,Ach,bch,Aeqch,beqch,lbch,ubch);
        [~, costg2v] = linprog(-1*ffg2v*tslot,Ach,bch,Aeqch,beqch,...
                                                                lbch,ubch);
        cost_v2g_g2v = costg2v - profit_v2g_g2v;
        evpow_v2g_g2v = final_pow(powv2g, powg2v);

        %% G2V Only Option 
        priority_id = (find(rankch == i));
        
        pattern_id = mod(priority_id,num_pattern);
        if pattern_id == 0
           pattern_id =  num_pattern;
        end
        only_g2v_price = pattern(pattern_id, :);
        price_g2v_only = only_g2v_price(arival(i):departure(i));

        A = [];
        b = [];
        l = length(price_g2v_only);
        Aeq = ones(1,l);
        beq = -cap_ev*(final_soc(i)-socini(i))/tslot;
        lower = zeros(1, ending-starting);
        upper = zeros(1, ending-starting);
            for k = starting : ending
                lower(k) = pmin_ev ;
                upper(k) = 0;
                if((k<=departure_min && k>=arrival_max) && sharepow)
                    lower(k) = -default;
                end
            end
        lb = lower(arival(i):departure(i));
        ub = zeros(1, l);
        [pow_g2v_only, ~] = linprog(-1*price_g2v_only*tslot,A,b,...
                                                            Aeq,beq,lb,ub);
        [~, cost_g2v_only] = linprog(-1*old_price*tslot,A,b,Aeq,beq,lb,ub);
        
        if cost_v2g_g2v - BDC(i) <=0
        G2V_V2G_CONDITION = true;
        else
            G2V_V2G_CONDITION = cost_g2v_only  <= cost_v2g_g2v - BDC(i);
        end

        if (G2V_V2G_CONDITION)
            num_g2v_only = num_g2v_only +1;
            final(i).before = zeros(arival(i)-starting, 1);
            final(i).after = zeros(ending -departure(i), 1);
            final(i).now= pow_g2v_only;
            final(i).def = [final(i).before;final(i).now;final(i).after];
  
            
        else
            num_g2v_v2g = num_g2v_v2g +1;
            final(i).before = zeros(arival(i)-starting, 1);
            final(i).after = zeros(ending -departure(i), 1);
            final(i).now = evpow_v2g_g2v;
            final(i).def = [final(i).before;final(i).now;final(i).after];

     

        end

     end  
   
     
    if i == 1
    else
        total_ev_pow = total_ev_pow + final(i-1).def;
    end
    
    
    %% ESS starts here
    else
        
     %% Put ESS here      
    %% Setting linear Programming Parameters A, b, lb, ub, Aeq, beq
    pricenew = new_price(low, high, low_time, high_time, last_time);
    l = length(pricenew);
    A = A_constraint(l);
    lp = mini_soc(socmin_ess, socini_ess, cap_ess, tslot);
    up = maxi_soc(socmax_ess, socini_ess, cap_ess, tslot);
    b = b_constraint(l, up, lp);
    
    %% ESS Charging feasibility
    % Remaining power to be given to ESS after EVS Scheduling
    ness = transformer_power*ones(ending - starting+1, 1)-total_ev_pow;
    ness = -ness;   
    lb = lb_v2g(pmin_ess, starting, ending,low_time,high_time, last_time);
    for j = 1:l
        if ness(j)>=0
            lb(j) = 0;
        elseif lb(j) < ness(j)
            lb(j) = ness(j);
            
        else
            lb(j) = pmin_ess;
        end                  
    end
    %% End of ESS Charging feasibility
    %% ESS Power Sale
    ub = ub_v2g(pmax_ess, starting, ending,low_time,high_time, last_time);
    %% End of ESS Power Sale
    Aeq = [];
    beq = [];
    
    % ESS Charging and Discharging is set as earlier as possible, using
    % pricenew, which does not impact on real cost
     pricenew = new_price(low, high, low_time, high_time, last_time);
    [pow_ess, ~] = linprog(-1*pricenew*tslot,A,b,Aeq,beq,lb,ub);
    % Real Cost is found from original price
    [~, realcost_ess] = linprog(-1*priceold*tslot,A,b,Aeq,beq,lb,ub);

 

    end
     %% End of  ess
end
%% End of PL 
toc
