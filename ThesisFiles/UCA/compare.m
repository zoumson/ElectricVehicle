
clc
clear 
% Reduction in cost 
UCA = [602.3649, 1039, 2405.7, 5293.5, 7848.7,10486,13117, 15488,...
    18127, 19936, 22746, 25832];


BCA = [470.73, 838.82, 1991, 4480.8, 6140.6,8172.6,10485,12872,...
14445,16493,18932, 21169]; 

charging = [468.15, 835.82, 1987.12, 4470.8, 6129.2, 8170.8,10482,12870,...
14441,16492,18930, 21161];
 

proposed = [441.08, 793.068, 1806.3, 3880.6, 5445.1,7151,9023.9,11187,...
12651,14271,16563, 18149];

de = [486.265, 904.285, 2074.7, 4527.4, 6471.7,8701.3,10886,13304,...
15149,17227,19697, 21911];




percentage_traditional = per(UCA, BCA);
traditional_mean = mean(percentage_traditional);

percentage_proposed = per(UCA, proposed);
proposed_mean = mean(percentage_proposed);

percentage_charging = per(UCA, charging);
charging_mean = mean(percentage_charging);
percentage_de = per(UCA, de);
de_mean = mean(percentage_de);


