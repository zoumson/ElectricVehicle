clear
clc
close all

confidence_interval = 0:.1:1;
% %% 500
% cost_ev_500_100_grid = [335.55, 340.15, 340.38*ones(1, 9)];
% 
% cost_ev_500_500_grid = [307.1, 312.23, 312.89, 315.57, 316.53, 319.04,319.57,322.14,323.1, 327.8,  335.61];
% cost_ev_500_1000_grid = [271.84, 276.12, 280.42, 282.01, 284.63,287.43,289.65, 291.1, 291.9, 294.4, 299.9];
% cost_ev_500_2000_grid = 240.14*ones(1, 11);
% 
% cost = cat(2,cost_ev_500_100_grid,cost_ev_500_500_grid,cost_ev_500_1000_grid,cost_ev_500_2000_grid);
% %% 400
% cost_ev_500_100_grid = [262.3090  266.2955  266.8516  266.8516  266.8516  266.8516  266.8516  266.8516  266.8516  266.8516  266.8516];
% 
% cost_ev_500_500_grid = [232.3943  238.2963  240.5817  242.9641  244.0418  244.5842  245.8240  249.2069  251.0867  254.7258  262.5291];
% cost_ev_500_1000_grid = [195.0072  200.5242  202.4125  205.0192  207.2804  208.8979  209.4930  211.6244  214.5479  218.7183  224.0678];
% cost_ev_500_2000_grid = [177.2275  177.2275  177.2275  177.2275  177.2275  177.2275  177.2275  177.2275  177.2275  177.2275  177.2275];
% 
% cost = cat(2,cost_ev_500_100_grid,cost_ev_500_500_grid,cost_ev_500_1000_grid,cost_ev_500_2000_grid);

% 200
cost_ev_500_100_grid = [127.5194  133.9081  134.1798  134.1798  134.1798  134.1798  134.1798  134.1798  134.1798  134.1798  134.1798];

cost_ev_500_500_grid = [101.7099  108.1229  109.8842  110.9561  112.1167  115.3939  117.0281  118.2278  119.3867  121.3429  128.6468];
cost_ev_500_1000_grid = [100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819];
cost_ev_500_2000_grid = [100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819  100.3819];

cost = cat(2,cost_ev_500_100_grid,cost_ev_500_500_grid,cost_ev_500_1000_grid,cost_ev_500_2000_grid);


cost_grid = [cost_ev_500_100_grid; cost_ev_500_500_grid; cost_ev_500_1000_grid; cost_ev_500_2000_grid];

grid_request = [100, 500, 1000, 2000];

grid_request_mat = repmat(grid_request, numel(confidence_interval));

minn = min(cost);
maxx = max(cost);
fig = figure('Name','Simulation result','units','normalized','outerposition',[0 0 0.45 0.45]);

evNum = 200;

name = strcat('ev_', num2str(evNum), '_confidence_grid_cost.png');
h = surf(confidence_interval, grid_request, cost_grid );



for j = 1:numel(grid_request)
 hold on

%%highlight points greater than 0 hour 

plot3(confidence_interval, grid_request_mat(:, j), cost_grid(j, :),'-wo', 'MarkerEdgeColor','w',...
    'MarkerFaceColor','w','markersize',3, 'linewidth', 5);

end

c =colorbar;

xlabel('PV confidence level')
ylabel('Grid request(kW)')
yticks([100, 500, 1000, 2000])
zlabel('Cost($)')

set(gca,'FontSize',10);
% whitebg(40*ones(1,3)/256);
grid on

c.Color = 'k';
set(gca,'xcolor','k') 
set(gca,'ycolor','k')
set(gca,'zcolor','k')
set(gca,'GridAlpha',0.8)
set(gca,'GridColor','k')
% set(gca,'MinorGridColor','w')
set(gca,'GridLineStyle',':')

set(gcf,'color','w');
hZLabel = get(gca,'ZLabel');
set(hZLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')


[caz,cel] = view;
v = [-5 10 10];
[caz,cel] = view(v);

  print(fig,name,'-dpng','-r300');
% 
% name = 'ev_200_confidence_level_vs_grid_request.png';
% p1 = plot(confidence_interval,cost_ev_500_100_grid, '--kd',...
%     'LineWidth',2,...
%     'MarkerEdgeColor','k',...
%     'MarkerFaceColor','k',...
%     'MarkerSize',10);
% 
% hold on
% p2 = plot(confidence_interval,cost_ev_500_500_grid, ':bv',...
%     'LineWidth',2,...
%     'MarkerEdgeColor','b',...
%     'MarkerFaceColor','b',...
%     'MarkerSize',10);
% 
%  
% hold on
% p3 = plot(confidence_interval, cost_ev_500_1000_grid+0.5, '-.go',...
%     'LineWidth',2,...
%     'MarkerEdgeColor','g',...
%     'MarkerFaceColor','g',...
%     'MarkerSize',10);
% 
% hold on
% p4 = plot(confidence_interval, cost_ev_500_2000_grid, '-rs',...
%     'LineWidth',2,...
%     'MarkerEdgeColor','r',...
%     'MarkerFaceColor','r',...
%     'MarkerSize',10);
% hold on
% %  l = length(confidence_interval);
%     x = [0 1];
%  y = (maxx + 20)*ones(1,2);
%     line(x,y,'Color','none');
%     
%     hold on
%      y = (minn - 20)*ones(1,2);
%     line(x,y,'Color','none');
% legend([p1, p2, p3, p4],  'Grid request: 100kW', 'Grid request: 500kW',...
%     'Grid request: 1000kW','Grid request: 2000kW');
%     xlabel('PV confidence level');
%     ylabel('Cost($)');
%     xticks(0: .1:11);
%     yticks(minn :(maxx-minn)/5: maxx);
% % xticklabels(num2str(confidence_interval)) ;  
% hYLabel = get(gca,'YLabel');
% set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% ax = findall(fig, 'type', 'axes');
% set(ax,'FontSize',15)    
%     
% % print(fig,name,'-dpng','-r300');   
%     
%     
%     