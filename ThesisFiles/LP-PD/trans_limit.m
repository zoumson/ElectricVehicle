function  trans_limit(f, total, ptmax)

l = length(f);
p1 = zeros(1, l);
p2 = zeros(1, l);
p3 = zeros(1, l);
p4 = zeros(1, l);
for i = 1: l
    if f(i) == ptmax 
        p1(i) = ptmax;
        p3(i) = -ptmax;
        %p2(i) = 0;
    else
        p1(i) = 0;
        p2(i) = f(i);
        p4(i) = - f(i);
        
    end
    
end



l = length(total);
pow1 = zeros(1, l);
pow2 = zeros(1, l);

for i = 1:l
    if total(i) < 0
        pow1(i) = total(i);
    else
        pow2(i) = total(i);
    end
        
end

bar(p1, 'r')
hold on 
bar(p3, 'r')
hold on 

bar(p2, 'w')
hold on
bar(p4, 'w')
hold on
bar(pow2, 'b')
hold on
bar(pow1, 'g')
legend('Not in station', '', 'Transformer Limit','',  'Buying Power', 'Selling Power')
title('Overall Power Coverage')
set(gca,'FontSize',20);

end