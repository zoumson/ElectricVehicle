function pat1 = pattern1(low, high, low_time, high_time, last_time)
%% TOU Modification 
% Setting Levelings intervals
% low_time first interval where price is low(leftermost side)
% last_time second interval(rightermost side) where price is low
% high_time  interval in middle where price is low

    % Increasing Leveling
    v1 = low/low_time:low/low_time :low;
    % Increasing Leveling
    v2 = low + (high-low)/high_time:(high-low)/high_time :high;
    % Pair of opposite levelings
    v3 = cat(2, v1, v2);
     % Increasing Leveling
    v4 = low/last_time:low/last_time :low;
    % Grouping all levelings pairs
    pat1 = cat(2, v3, v4);


end

