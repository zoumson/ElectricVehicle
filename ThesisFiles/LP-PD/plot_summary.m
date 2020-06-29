clc
clear
close all
data =load('summary.mat');
% data =load('monteData.mat');
x = data.monte(1, 1:30);
t = struct2table(x);
ab_200 = t.("contract_capacity_ALL_200");
ab_200 = ab_200(1, :);
ord_ev_200 = t.("Cost_EV_200");
ord_agg_200 = t.("Cost_Agg_200");
ord_all_200 = t.("Utility_ALL_200");

ab_400 = t.("contract_capacity_ALL_400");
ab_400 = ab_400(1, :);
ord_ev_400 = t.("Cost_EV_400");
ord_agg_400 = t.("Cost_Agg_400");
ord_all_400 = t.("Utility_ALL_400");

ab_500 = t.("contract_capacity_ALL_500");
ab_500 = ab_500(1, :);
ord_ev_500 = t.("Cost_EV_500");
ord_agg_500 = t.("Cost_Agg_500");
ord_all_500 = t.("Utility_ALL_500");
cap = t.("contract_capacity_ALL_200");
s = summary(t);
im200 = s.("PL_EV_200");
im400 = s.("PL_EV_400");
im500 = s.("PL_EV_500");
% boxplot(or)
% % % summ = summary(t);
% % writetable(t,'f.xls');
% 
% rng default  % For reproducibility
% x = randn(100,25);

% f1 = figure('Name','PS 200','units','normalized','outerposition',[0 0 0.8 1]);
% 
% 
% subplot(3,1,1)
% b1 = boxplot(ord_ev_200,'Notch','on','Whisker',1);
% xlabel('Contract capacity (kW)')
% ylabel({'EV Cost  ';'index    '})
% % {'Agg-EV Utility';'index'}
% set(gca,'XTickLabel',{'500 ' , '555 ', '611 ','666 ', '722 ', '777 ' , '833 ', '888 ','944 ' , '1000'})
% % set(gca,'FontSize',20)
% % display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% set(b1,{'linew'},{2})
% 
% subplot(3,1,2)
% b2 = boxplot(ord_agg_200,'Notch','on','Whisker',1);
% set(gca,'XTickLabel',{'500 ' , '555 ', '611 ','666 ', '722 ', '777 ' , '833 ', '888 ','944 ' , '1000'})
% % set(gca,'FontSize',20)
% xlabel('Contract capacity (kW)')
% ylabel({'Agg Cost ';'index  '})
% 
% % display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% set(b2,{'linew'},{2})
% 
% subplot(3,1,3)
% b3 = boxplot(ord_all_200,'Notch','on','Whisker',1);
% xlabel('Contract capacity (kW)')
% ylabel({'Agg-EV  ' ; 'Utility  ';'index  '})
% set(gca,'XTickLabel',{'500 ' , '555 ', '611 ','666 ', '722 ', '777 ' , '833 ', '888 ','944 ' , '1000'})
% % set(gca,'FontSize',20)
% % display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% ax1 = findall(f1, 'type', 'axes');
% set(ax1,'FontSize',25, 'FontWeight', 'bold')
% set(b3,{'linew'},{2})
% % print(f1,'PL200.png','-dpng','-r300');
%% new for 200 EVs
% f1 = figure('Name','PS 200','units','normalized','outerposition',[0 0 1 1]);
% 
% 
% subplot(3,1,1)
% b11 = boxplot(ord_ev_200,'Notch','on','Whisker',1);
% % xlabel('Contract capacity (kW)')
% xlabel('CC(kW)')
% % set(gca,'xticklabel',{[]})
% % ylabel({'EV Cost  ';'index    '})
% title('EV Cost Index');
% set(gca,'XTickLabel',{'500 ' , '555 ', '611 ','666 ', '722 ', '777 ' , '833 ', '888 ','944 ' , '1000'})% display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% set(b11,{'linew'},{2})
% 
% 
% 
% subplot(3,1,2)
% b22 = boxplot(ord_agg_200,'Notch','on','Whisker',1);
% set(gca,'XTickLabel',{'500 ' , '555 ', '611 ','666 ', '722 ', '777 ' , '833 ', '888 ','944 ' , '1000'})
% title('Aggregator Cost Index');
% xlabel('CC(kW)')
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% set(b22,{'linew'},{2})
% subplot(3,1,3)
% 
% b33 = boxplot(ord_all_200,'Notch','on','Whisker',1);
% xlabel('CC(kW)')
% % ylabel({'Agg-EV  ' ; 'Utility  ';'index  '})
% title('Aggregator and EVs Join Utility Index');
% set(gca,'XTickLabel',{'500 ' , '555 ', '611 ','666 ', '722 ', '777 ' , '833 ', '888 ','944 ' , '1000'})
% % display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% ax1 = findall(f1, 'type', 'axes');
% set(ax1,'FontSize',20, 'FontWeight', 'normal')
% set(b33,{'linew'},{2})
% 
% ha=get(gcf,'children');
%  set(ha(1),'position',[.05 .1 .95 .35])
%  set(ha(2),'position',[.55 .55 .45 .4])
%  set(ha(3),'position',[.05 .55 .45 .4])

%% new for 400 EVs
% f2 = figure('Name','PS 400','units','normalized','outerposition',[0 0 1 1]);
% 
% 
% subplot(3,1,1)
% b11 = boxplot(ord_ev_400,'Notch','on','Whisker',1);
% % xlabel('Contract capacity (kW)')
% xlabel('CC(kW)')
% % set(gca,'xticklabel',{[]})
% % ylabel({'EV Cost  ';'index    '})
% title('EV Cost Index');
% set(gca,'XTickLabel',{'1400','1455' ,'1511','1566','1622','1677','1733','1788','1844','1900'})
% % display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% set(b11,{'linew'},{2})
% 
% 
% 
% subplot(3,1,2)
% b22 = boxplot(ord_agg_400,'Notch','on','Whisker',1);
% set(gca,'XTickLabel',{'1400','1455' ,'1511','1566','1622','1677','1733','1788','1844','1900'})
% title('Aggregator Cost Index');
% xlabel('CC(kW)')
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% set(b22,{'linew'},{2})
% subplot(3,1,3)
% 
% b33 = boxplot(ord_all_400,'Notch','on','Whisker',1);
% xlabel('CC(kW)')
% % ylabel({'Agg-EV  ' ; 'Utility  ';'index  '})
% title('Aggregator and EVs Join Utility Index');
% set(gca,'XTickLabel',{'1400','1455' ,'1511','1566','1622','1677','1733','1788','1844','1900'})
% % display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% ax2 = findall(f2, 'type', 'axes');
% set(ax2,'FontSize',20, 'FontWeight', 'normal')
% set(b33,{'linew'},{2})
% 
% ha=get(gcf,'children');
%  set(ha(1),'position',[.05 .1 .95 .35])
%  set(ha(2),'position',[.55 .55 .45 .4])
%  set(ha(3),'position',[.05 .55 .45 .4])
%  
% 
% % print(f2,'PL400.png','-dpng','-r300');
%% new for 500 EVs
f3 = figure('Name','PS 500','units','normalized','outerposition',[0 0 1 1]);


subplot(3,1,1)
b11 = boxplot(ord_ev_500,'Notch','on','Whisker',1);
% xlabel('Contract capacity (kW)')
xlabel('CC(kW)')
% set(gca,'xticklabel',{[]})
% ylabel({'EV Cost  ';'index    '})
title('EV Cost Index');
set(gca,'XTickLabel',{'1900','1977' , '2055','2133' ,'2211', ' 2288','2366', '2444', '2522','2600'});
% display ylabel horizontally
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
set(b11,{'linew'},{2})



subplot(3,1,2)
b22 = boxplot(ord_agg_500,'Notch','on','Whisker',1);
set(gca,'XTickLabel',{'1900','1977' , '2055','2133' ,'2211', ' 2288','2366', '2444', '2522','2600'});
title('Aggregator Cost Index');
xlabel('CC(kW)')
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
set(b22,{'linew'},{2})
subplot(3,1,3)

b33 = boxplot(ord_all_500,'Notch','on','Whisker',1);
xlabel('CC(kW)')
% ylabel({'Agg-EV  ' ; 'Utility  ';'index  '})
title('Aggregator and EVs Join Utility Index');
set(gca,'XTickLabel',{'1900','1977' , '2055','2133' ,'2211', ' 2288','2366', '2444', '2522','2600'});
% display ylabel horizontally
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
ax3 = findall(f3, 'type', 'axes');
set(ax3,'FontSize',20, 'FontWeight', 'normal')
set(b33,{'linew'},{2})

ha=get(gcf,'children');
 set(ha(1),'position',[.05 .1 .95 .35])
 set(ha(2),'position',[.55 .55 .45 .4])
 set(ha(3),'position',[.05 .55 .45 .4])







% f3 = figure('Name','PS 500','units','normalized','outerposition',[0 0 1 1]);
% 
% subplot(3,1,1)
% b111 = boxplot(ord_ev_500,'Notch','on','Whisker',1);
% xlabel('Contract capacity (kW)')
% ylabel('EV Cost index')
% set(gca,'XTickLabel',{'1900','1977.8' , '2055.6','2133.3' ,'2211.1', ' 2288.9','2366.7', '2444.4', '2522.2','2600'});
% % display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% set(b111,{'linew'},{2})
% 
% subplot(3,1,2)
% b222 = boxplot(ord_agg_500,'Notch','on','Whisker',1);
% set(gca,'XTickLabel',{'1900','1977.8' , '2055.6','2133.3' ,'2211.1', ' 2288.9','2366.7', '2444.4', '2522.2','2600'});xlabel('Contract capacity (kW)')
% ylabel('Agg Cost index')
% 
% % display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% set(b222,{'linew'},{2})
% 
% subplot(3,1,3)
% b333 = boxplot(ord_all_500,'Notch','on','Whisker',1);
% xlabel('Contract capacity (kW)')
% ylabel('Agg-EV Utility index')
% set(gca,'XTickLabel',{'1900','1977.8' , '2055.6','2133.3' ,'2211.1', ' 2288.9','2366.7', '2444.4', '2522.2','2600'});
% % display ylabel horizontally
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% ax3 = findall(f3, 'type', 'axes');
% set(ax3,'FontSize',15)
% set(b333,{'linew'},{2})
% print(f3,'PL500.png','-dpng','-r300');

% 
% 
% 
