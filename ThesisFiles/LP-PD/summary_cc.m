
clear
clc
close all


%% ev 200

cc_200 = [500   555.6    611.1    666.7    722.2    777.8    833.3    888.9    944.4    1000];
cost_200 = [123.535, 118.6437, 114.1426,  110.0368, 105.5697,  102.0285, 100.3739, 97.6927, 95.1966, 92.8];
v2g_200 = [68, 75, 82, 89, 96, 101, 104, 109, 115, 121];

v2g_200_ratio = v2g_200*100./200;

%% ev 200
 
cc_400 = [1400   1455.6    1511.1    1566.7    1622.2    1677.8    1733.3    1788.9    1844.4    1900];
cost_400 = [196.5, 191.4, 187.1, 183.9, 179.6, 177.2, 175.6, 172, 168.1, 164.2];
v2g_400 = [182, 188, 195, 201, 208, 213, 217, 225, 232, 240];   
v2g_400_ratio = v2g_400*100./400;

%% ev 500
cc_500 = [1900    1977.8    2055.6    2133.3    2211.1    2288.9    2366.7    2444.4    2522.2    2600];
cost_500 = [251.9, 246.9, 244.2, 241, 234.7, 230.1, 227.8, 225.5, 225.5, 225.5];
v2g_500 = [250, 259, 268, 276, 287, 294, 300, 306, 306, 306];
v2g_500_ratio = v2g_500*100./500
  