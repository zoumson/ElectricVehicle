function  plot_price(f, fmax)

l = length(f);
p1 = zeros(1, l);
p2 = zeros(1, l);
for i = 1: l
    if f(i) == fmax 
        p1(i) = fmax;
        p2(i) = 0;
    else
        p1(i) = 0;
        p2(i) = f(i);
        
    end
    
end

bar(p1, 'r')
hold on 
bar(p2, 'g')

legend('Not in station', 'In Station')
%title('Electricity Price')
set(gca,'FontSize',20);

end