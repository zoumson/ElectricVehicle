function plot_pow(pow, trans)
% Plot power, red is discahrging, green is charging
   
   l =length(pow);
    b = bar(pow, 'green');
    x = [0 l];
    y = trans*ones(1,2);
    hold on
    tr = line(x,y,'Color','black','LineStyle','--','LineWidth',5);
    hold on
    x = [0 l];
    y = (trans - 10)*ones(1,2);
    line(x,y,'Color','none');
    
    xlabel('Time Slot(5 min) 24 --> 1 hour ')
    ylabel('Power(kW)')
    xticks(0 :24: l);
    yticks(min(pow):500:max(pow));
    legend([b, tr], 'Total Power purchased', 'Transformer Power')
    %title('TCA Scheduled Power')
    set(gca,'FontSize',20)
    

end