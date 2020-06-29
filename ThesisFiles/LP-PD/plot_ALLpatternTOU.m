
clc
clear
close all

%% Electricity Price
low = 1.69;
high = 3.62;

% Time slot
minute  = 5;
tslot = minute/60;

% Low electricity price periods
% low_time = 8/tslot;
  low_time = 7.5/tslot;
% High electricity price periods
% high_time = 9/tslot; 
  high_time = 15/tslot;
% Low electricity price periods
% last_time = 7/tslot;
  last_time = 1.5/tslot;


% reference price from the grid 
priceOriginal = normal_price(low, high, low_time, high_time, last_time);

% 3 charging price patterns
pattern = [pattern1(low, high, low_time, high_time, last_time);...
    pattern2(low, high, low_time, high_time, last_time);...
    pattern3(low, high, low_time, high_time, last_time)];

%  for nPattern = 1:size(pattern, 1)
       for nPattern = 1:1
priceModified = pattern(nPattern, :);
nameModified = strcat('Pattern', num2str(nPattern), '.png');
plot_price_pattern(priceOriginal,priceModified, nameModified);
end

