
clc;
clear ;
close all;
profit = [11.0583, 35.2719, 16.0306, 47.6618; ...
    11.0583, 35.2021, 15.1451, 47.6618;...
    11.0583, 34.8104, 14.5781, 47.6618;...
    11.0583, 30.4265, 7.8792, 47.6618;...
    11.0583, 26.8082, 2.5055, 47.6618;...
     11.0583, 26.6852, 0, 47.6618];
titleSize = 15;
perSize = 15;
fig = figure('Name','Profit','units','normalized','outerposition',[0 0 0.7 .9]);
% label ={'ESS Profit', 'G2V Profit', 'V2G Profit', 'PV Profit'};
% % pie3(profit(1, :))
% X = profit;
% L = label;
% % L = {'A','B','C','D','E'};
% % X = [  1,  3,0.5,2.5,  2];
% explode = [0, 0, 1, 0];
% 
% subplot(3,2,1);
% p = pie3(X(1, :), explode)
% 
% colormap(gca, [0 0 1;      %// blue
%           .5 .5 .5;      %// grey
%           1 0 0;      %// red
%           0 1 0]) %// green
% pText = findobj(p,'Type','text');
% % percentValues = get(pText,'String'); 
% % txt = {'ESS Profit: ';'G2V Profit: ';'V2G Profit: '; 'PV Profit: '};%{'Item A: ';'Item B: ';'Item C: '}; 
% % combinedtxt = strcat(txt,percentValues); 
% % pText(1).String = combinedtxt(1);
% % pText(2).String = combinedtxt(2);
% % pText(3).String = combinedtxt(3);
% % pText(4).String = combinedtxt(4);
% % 
% set(pText,'FontSize',perSize)
% 
% title({'V2G Penetration: 100%'}, 'fontsize', titleSize, 'Units', 'normalized', 'Position', [0, 1, 1])
% ax = gca;
% 
% [caz,cel] = view;
% v = [-10 0 5];
% [caz,cel] = view(v);
% legend(label);
% subplot(3,2,2);
% p = pie3(X(2, :), explode);
% colormap(gca, [0 0 1;      %// blue
%           .5 .5 .5;      %// grey
%           1 0 0;      %// red
%           0 1 0]) %// green
% pText = findobj(p,'Type','text');
% % percentValues = get(pText,'String'); 
% % txt = {'ESS Profit: ';'G2V Profit: ';'V2G Profit: '; 'PV Profit: '};%{'Item A: ';'Item B: ';'Item C: '}; 
% % combinedtxt = strcat(txt,percentValues); 
% % pText(1).String = combinedtxt(1);
% % pText(2).String = combinedtxt(2);
% % pText(3).String = combinedtxt(3);
% % pText(4).String = combinedtxt(4);
% % 
% set(pText,'FontSize',perSize)
% 
% title({'V2G Penetration: 80%'}, 'fontsize', titleSize, 'Units', 'normalized', 'Position', [0, 1, 1])
% ax = gca;
% 
% [caz,cel] = view;
% v = [-10 0 5];
% [caz,cel] = view(v);
% 
% subplot(3,2,3);
% p = pie3(X(3, :), explode);
% colormap(gca, [0 0 1;      %// blue
%           .5 .5 .5;      %// grey
%           1 0 0;      %// red
%           0 1 0]) %// green
% pText = findobj(p,'Type','text');
% % percentValues = get(pText,'String'); 
% % txt = {'ESS Profit: ';'G2V Profit: ';'V2G Profit: '; 'PV Profit: '};%{'Item A: ';'Item B: ';'Item C: '}; 
% % combinedtxt = strcat(txt,percentValues); 
% % pText(1).String = combinedtxt(1);
% % pText(2).String = combinedtxt(2);
% % pText(3).String = combinedtxt(3);
% % pText(4).String = combinedtxt(4);
% % 
% set(pText,'FontSize',perSize)
% 
% title({'V2G Penetration: 60%'}, 'fontsize', titleSize, 'Units', 'normalized', 'Position', [0, 1, 1])
% ax = gca;
% 
% [caz,cel] = view;
% v = [-10 0 5];
% [caz,cel] = view(v);
% 
% 
% subplot(3,2,4);
% p = pie3(X(4, :), explode);
% colormap(gca, [0 0 1;      %// blue
%           .5 .5 .5;      %// grey
%           1 0 0;      %// red
%           0 1 0]) %// green
% pText = findobj(p,'Type','text');
% % percentValues = get(pText,'String'); 
% % txt = {'ESS Profit: ';'G2V Profit: ';'V2G Profit: '; 'PV Profit: '};%{'Item A: ';'Item B: ';'Item C: '}; 
% % combinedtxt = strcat(txt,percentValues); 
% % pText(1).String = combinedtxt(1);
% % pText(2).String = combinedtxt(2);
% % pText(3).String = combinedtxt(3);
% % pText(4).String = combinedtxt(4);
% % 
% set(pText,'FontSize',perSize)
% 
% title({'V2G Penetration: 40%'}, 'fontsize', titleSize, 'Units', 'normalized', 'Position', [0, 1, 1])
% ax = gca;
% 
% [caz,cel] = view;
% v = [-10 0 5];
% [caz,cel] = view(v);
% 
% 
% subplot(3,2,5);
% p = pie3(X(5, :), explode);
% colormap(gca, [0 0 1;      %// blue
%           .5 .5 .5;      %// grey
%           1 0 0;      %// red
%           0 1 0]) %// green
% pText = findobj(p,'Type','text');
% % percentValues = get(pText,'String'); 
% % txt = {'ESS Profit: ';'G2V Profit: ';'V2G Profit: '; 'PV Profit: '};%{'Item A: ';'Item B: ';'Item C: '}; 
% % combinedtxt = strcat(txt,percentValues); 
% % pText(1).String = combinedtxt(1);
% % pText(2).String = combinedtxt(2);
% % pText(3).String = combinedtxt(3);
% % pText(4).String = combinedtxt(4);
% % 
% set(pText,'FontSize',perSize)
% 
% title({'V2G Penetration: 20%'}, 'fontsize', titleSize, 'Units', 'normalized', 'Position', [0, 1, 1])
% ax = gca;
% 
% [caz,cel] = view;
% v = [-10 0 5];
% [caz,cel] = view(v);
% 
% 
% 
% 
% 
% 
% 
% subplot(3,2,6);
% p = pie3(X(6, :), explode);
% colormap(gca, [0 0 1;      %// blue
%           .5 .5 .5;      %// grey
%           0 1 0]) %// green
% pText = findobj(p,'Type','text');
% % percentValues = get(pText,'String'); 
% % txt = {'ESS Profit: ';'G2V Profit: ';'V2G Profit: '; 'PV Profit: '};%{'Item A: ';'Item B: ';'Item C: '}; 
% % combinedtxt = strcat(txt,percentValues); 
% % pText(1).String = combinedtxt(1);
% % pText(2).String = combinedtxt(2);
% % pText(3).String = combinedtxt(3);
% % pText(4).String = combinedtxt(4);
% % 
% set(pText,'FontSize',perSize)
% 
% title({'V2G Penetration: 0%'}, 'fontsize', titleSize, 'Units', 'normalized', 'Position', [0, 1, 1])
% ax = gca;
% 
% [caz,cel] = view;
% v = [-10 0 5];
% [caz,cel] = view(v);
% 
% % ha=get(gcf,'children');
% %  set(ha(1),'position',[0 .05  .45 .2])
% %  set(ha(2),'position',[0 .35 .45 .2])
% %  set(ha(3),'position',[0 .65 .45 .2])
% %  
% %  set(ha(4),'position',[.3 .05 0.7 .2])
% %  set(ha(5),'position',[.5 .35 .3 .2])
% % set(ha(7),'position',[.5 .65 .3 .2])
% 
% 
% 
profit_100_0 = sum(profit,2).';
profit_0_100 = fliplr(profit_100_0);

profit_all_row = [min(profit_0_100)*ones(size(profit_0_100));profit_0_100 - min(profit_0_100)];
profit_all_col = profit_all_row.';
% 
% bb = bar3(profit_all,'stacked')
% ylabel('V2G Penetration (%)')
% zlabel('Profit');
% yticklabels({'0','20','40','60','80','100'})
% % bb.EdgeColor ='blue';
% % bb.LineStyle =  ':';
% % bb.LineWidth =  3;
% % bb.FaceColor =  'blue';
% % bb.FaceAlpha =  0.5;
% hZLabel = get(gca,'ZLabel');
% set(hZLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')






%% Bar plot
bh = barh(profit_all_col, 'stacked')
yticklabels({'0','20','40','60','80','100'})
xlabel('Profit ($)');
ylabel('V2G Penetration (%)')
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')

legend('Only G2V', 'G2V && V2G')
 ax = findall(fig, 'type', 'axes');
set(ax,'FontSize',15)