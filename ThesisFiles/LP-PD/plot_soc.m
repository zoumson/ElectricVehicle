function plot_soc(soci, pow, cap, tslot)
%% This function plot SOC for given power sequence
time = length(pow);
et = zeros(time, 1);
for i = 1:time
    if (i == 1)
        et(i) = v2g_soc(soci, pow(i), cap, tslot);

    else
   et(i) = v2g_soc(et(i-1), pow(i), cap, tslot);
    end
end
soc = cat(1, soci, et);
plot( 100*soc, 'LineWidth', 5);
xlabel('Time Slot(5 min)')
ylabel('SOC(%)')
set(gca,'FontSize',20);
whitebg('k');

end