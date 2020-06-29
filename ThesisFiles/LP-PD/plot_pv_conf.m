function  plot_pv_conf(evPow, essPow, pvPow, loadPow, gridPow, trans, name,v2g, conf)
% main plot for overall

fig = figure('Name','Total Power','units','normalized','outerposition',[0 0 1 1]);
    l = length(evPow);
    x = [0 l];
    xx = 0:4:l; 
    ll = numel(xx);
    maxGrid = max(gridPow);
    gridPow = maxGrid*ones(1, ll);
    yy = -trans*ones(1, ll);
    y = trans*ones(1,2);
     y_0_axis = zeros(1,2);
%     t1 = line(x,y,'Color','black','LineStyle','--','LineWidth',2);
%     hold on
% contract capacity
t2 = plot(xx,yy,'-kd',...
    'LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','k',...
    'MarkerSize',10);
% t2 = scatter(xx,yy,'MarkerFaceColor','w','MarkerEdgeColor','k', 'Marker', '^');
% t2.SizeData = 20; 
% t2 = plot(xx,yy,'Color','black','LineStyle','-','LineWidth',1,...
%        'MarkerSize', 3, 'Marker', 'o');   

%    t2 = line(x,-y,'Color','black','LineStyle','-','LineWidth',2,...
%        'MarkerSize', 5, 'Marker', '*');
%    
    
   hold on
 % widen y axis   
 if v2g
    y = (trans + 10)*ones(1,2);
    line(x,y,'Color','none');
    hold on
 else
     y = 10*ones(1,2);
    line(x,y,'Color','none');
    hold on
 end
    y = (-trans - 10)*ones(1,2);
    line(x,y,'Color','none');
    hold on    
l = length(evPow);
pow1 = zeros(1, l);
pow2 = zeros(1, l);

for i = 1:l
    if evPow(i) < 0
        pow1(i) = evPow(i);
    else
        pow2(i) = evPow(i);
    end
        
end


% v2g power
%  b1 = bar(pow2, 'FaceColor','w','EdgeColor','k','LineWidth',0.1);
b1 = bar(pow2, 'FaceColor','w','EdgeColor','none');
hatchfill2(b1,'HatchStyle','single','HatchAngle',0, 'facecolor', 'w',...
    'HatchColor', 'r', 'HatchLineWidth', 2,'LineWidth', 1, ...
    'HatchDensity',100);
% g2v power
hold on
dis = plot(nan, nan, '--r','LineWidth',1.5);
b2 = bar(pow1, 'FaceColor','g','EdgeColor','g','LineWidth',1.5);

hold on
% eclipse y = 0 axis
y_0_axis_plot = line(x,y_0_axis,'Color','k','LineStyle','-','LineWidth',2);

hold on 
% ess
 essPl = plot(essPow,'-bv',...
    'LineWidth',1,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor','w',...
    'MarkerSize',5);
 hold on 
 % pv
 pvPl = plot(pvPow,'-.ko',...
    'LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','y',...
    'MarkerSize',5);
  hold on 
  % load
 loPl = plot(loadPow,'-ms',...
    'LineWidth',1,...
    'MarkerEdgeColor','m',...
    'MarkerFaceColor','w',...
    'MarkerSize',5);
  hold on 
 % grid
 gdPl = plot(xx, gridPow,'-kp',...
    'LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','k',...
    'MarkerSize',10);
% 'Transformer Limit'
pvName = strcat('PV Confidence:', num2str(conf));
if(v2g)
legend([b2, dis, t2, loPl, pvPl, essPl, gdPl],  'EV Charging Power', 'EV Discharging Power',...
    'Contract Capacity','Load', pvName, 'ESS', 'Grid Request');
    xlabel('Time Slot(5 min) 24 --> 2 hours ');
    ylabel('Power(kW)');
    xticks(0 :24: l);
%     yticks([-trans, 0, max(pow2)]);
else
    legend([b2, t2],  'Charging Power','Transformer Limit')
 legend([b2, t2, loPl, pvPl, essPl, gdPl],  'EV Charging Power',...
    'Contract Capacity','Load', pvName, 'ESS', 'Grid Request');   
    
    xlabel('Time Slot(5 min) 24 --> 2 hours ');
    ylabel('Power(kW)');
    xticks(0 :24: l);
%     yticks([-trans, 0]);
end

 

%title('BLP Scheduled Power')
% display ylabel horizontally
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
ax = findall(fig, 'type', 'axes');
set(ax,'FontSize',24)
% set(ax,'FontSize',15)
% print(fig,name,'-dpng','-r300');

%whitebg('w');

end