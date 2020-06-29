function pat3 = pattern3(low, high, low_time, high_time, last_time)

%% TOU Modification 
% Setting Levelings intervals
% low_time first interval where price is low(leftermost side)
% last_time second interval(rightermost side) where price is low
% high_time  interval in middle where price is low
% Each interval is divided by 2, either one decreasing price either 
% other one increasing price
    high_time1 = high_time/2;
    high_time2 = high_time1;
    
    if (ceil(high_time1)~= high_time1)
        high_time1 = ceil(high_time1);
        high_time2 = high_time1-1;
    end

    low_time1 = low_time/2;
    low_time2 = low_time1;
    if (ceil(low_time1)~= low_time1)
        low_time1 = ceil(low_time1);
        low_time2 = low_time1-1;
    end
    
    last_time1 = last_time/2;
    last_time2 = last_time1;
    if (ceil(last_time1)~= last_time1)
        last_time1 = ceil(last_time1);
        last_time2 = last_time1-1;
    end
    % Decreasing Leveling
    v1 = low:-low/low_time1 :low/low_time1;
    % Increasing Leveling
    v11 = low/low_time2:low/low_time2 :low;
    % Pair of opposite levelings 
    v111 = cat(2, v1, v11);
    % Increasing Leveling
    v2 = low + (high-low)/high_time1:(high-low)/high_time1 :high;
    % Decreasing Leveling
    v22 = high:-(high-low)/high_time2 :low + (high-low)/high_time2;
    % Pair of opposite levelings 
    v222 = cat(2, v2, v22);
    % Decreasing Leveling
    v3 = low:-low/last_time1 :low/last_time1;
    % Increasing Leveling
    v33 = low/last_time2:low/last_time2 :low;
    % Pair of opposite levelings 
    v333 = cat(2, v3, v33);
    % Grouping all 3 levelings pairs
    v12 = cat(2, v111, v222);
    v13 = cat(2, v12, v333);
    
    pat3 = v13;



end