function plot_price_pattern(priceOriginal,priceModified, nameModified)





%% pattern plot 
% charging cost amount 
% fig = figure('Name','Price Pattern','units','normalized','outerposition',[0 0 1 1]);
% fig = figure('Name','Price Pattern','units','normalized','outerposition',[0 0 0.18 0.25]);
fig = figure('Name','Price Pattern','units','normalized','outerposition',[0 0 1 .45]);

sizee = 24;
maxx = max(priceOriginal/30);
l = length(priceOriginal);
b1 = bar( priceOriginal/30, 'FaceColor','k','EdgeColor','b','LineWidth',3);
hold on
b2 = bar( priceModified/30);
hatchfill2(b2,'HatchStyle','single','HatchAngle',0, 'facecolor', 'w',...
    'HatchColor', 'b', 'HatchLineWidth', 2,'LineWidth', 0.1, ...
    'HatchDensity',10);
hold on

dis2 = plot(nan, nan, '-b','LineWidth',1.5);
hold on
dis1 = patch(nan, nan, 'b');

hold on
plot([0, 5], [0, 0.22], 'color', 'none')


legend([dis1, dis2],  'Original TOU', 'Modified TOU','Location', 'northeast', 'fontsize', sizee)
    xlabel('Time Slot(5 min) 48 --> 4 hours ', 'fontsize', sizee);
    xticks(0 :48: l);
    yticks([0, 0.05, 0.12]);
 
ylabel('Price($)')
% display ylabel horizontally
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
ax = findall(fig, 'type', 'axes');
 set(ax,'FontSize',sizee)
%    print(fig,nameModified,'-dpng','-r300');

end