function plot_price(price, cost, word)
%% This function plot the Electricity pricing and is used to show the 
% charging cost amount 
bar( price);
xlabel('Time Slot(5 min)')
ylabel('Price($NT)')
title(['Daily Electricity  Price, Total Cost = ', num2str(cost),' $NT     ', num2str(word)],'Color', 'y', 'FontSize', 20)
set(gca,'FontSize',20);
whitebg('k');

end
