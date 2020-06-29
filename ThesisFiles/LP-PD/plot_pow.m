function plot_pow(pow)
%% This function plot power for given power sequence
% Red is discharging Power(V2G)
% Green is charging Power (G2v)
l = length(pow);
pow1 = zeros(1, l);
pow2 = zeros(1, l);
for i = 1:l
    if(pow(i)<= 0)
        pow1(i) = pow(i);
    else
        pow2(i) = pow(i);
    end
end


bar(pow1, 'green');
hold on 
bar(pow2, 'red');
xlabel('Time Slot(5 min)')
ylabel('Power(kW)')
legend({'Charging Power','DisCharging Power'}, 'FontSize', 20)
%title('500 EVS Scheduling Cumulative Power over one day')
set(gca,'FontSize',20)
whitebg('k');

end