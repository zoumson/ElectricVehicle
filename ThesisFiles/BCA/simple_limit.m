function  simple_limit(f, total, ptmax)

l = length(f);
p1 = zeros(1, l);
p2 = zeros(1, l);
for i = 1: l
    if f(i) == ptmax 
        p1(i) = ptmax;
        p2(i) = 0;
    else
        p1(i) = 0;
        p2(i) = f(i);
        
    end
    
end

bb1 = bar(p1, 'r');
hold on 
bb2 = bar(p2, 'w');
hold on
bar(total, 'b')



legend([bb1 bb2],'Not in station', 'Transformer Limit', 'Consumed Power')
%%legend('Not in station', 'Transformer Limit', 'Consumed Power')
title('Overall Power Coverage')
xlabel('Time Slot(5 min)')
ylabel('Power(kW)')
set(gca,'FontSize',20);

end