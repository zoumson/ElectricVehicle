function pat2 = pattern2(low, high, low_time, high_time, last_time)
%% TOU Modification 
% Setting Levelings intervals
% low_time first interval where price is low(leftermost side)
% last_time second interval(rightermost side) where price is low
% high_time  interval in middle where price is low

    % Decreasing Leveling
    v1 = low:-low/low_time :low/low_time;
    % Decreasing Leveling
    v2 = high:-(high-low)/high_time :low + (high-low)/high_time;
    % Pair of opposite levelings 
    v3 = cat(2, v1, v2);
    v4 = low:-low/last_time :low/last_time;
     % Grouping all levelings pairs
    pat2 = cat(2, v3, v4);


end


