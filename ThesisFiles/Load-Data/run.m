clc
clear 
close all
% opts = detectImportOptions('load.csv');
% preview('load.csv',opts)
% % data = readmatrix()

% opts.Sheet = '2007';
% opts.SelectedVariableNames = [1:5]; 
% opts.DataRange = '2:11';
loadData = readtimetable('load.csv');
nameLoad = 'loadPDF.png';
l = numel(loadData);
day24Hours = 24;
numLoadData = 70;
loadDataPerHour = zeros(24, numLoadData);
loadTimeHorizon = 1:100;
loadTotalTimeHour = 24*loadTimeHorizon(numLoadData);
col = 1;


for t = 1:loadTotalTimeHour

loadDataPerHour(loadData.Date(t, 1).Hour + 1, col) = loadData.Load(t,1);
if mod(t, day24Hours) == 0
    col = col + 1;
end
end

loadDataPerHour = loadDataPerHour/1000;

minLoadData = 9000/1000;
maxLoadData = 22000/1000;
stepLoadData = 100/1000;

givenLoadData = minLoadData:stepLoadData:maxLoadData;
pdfLoadValues= zeros(day24Hours,numel(givenLoadData));

allPdf(day24Hours) = struct();
for nHour= 1:day24Hours  
    allPdf(nHour).pdfLoad = fitdist(loadDataPerHour(nHour, :)','Normal');
    pdfLoadValues(nHour, :) = pdf(allPdf(nHour).pdfLoad,givenLoadData);
end


fig = figure('Name','Load PDF','units','normalized','outerposition',[0 0 0.4 0.45]);
h = surf(givenLoadData, (1:day24Hours)-1, pdfLoadValues);
c =colorbar;

% colormap(spring)
% colormap(spring)
xlabel('Load Power(kW)')
ylabel('Time covered(hrs)')
zlabel('PDF')

set(gca,'FontSize',10);
% whitebg(200*ones(1,3)/256);
grid on

c.Color = 'k';
set(gca,'xcolor','k') 
set(gca,'ycolor','k')
set(gca,'zcolor','k')
set(gca,'GridAlpha',0.8)
set(gca,'GridColor','w')
% set(gca,'MinorGridColor','w')
set(gca,'GridLineStyle','-')

set(gcf,'color','w');
ax = gca; % Get handle to current axes.
% ax.GridAlpha = 1;  % Make grid lines less transparent.
% ax.GridColor = 'k'; % Dark Green.


%  hold on
% 
% %%highlight 0 hour 
% 
% plot3(givenLoadData, zeros(numel(givenLoadData), 1), pdfLoadValues(1, :),'-w','markersize',10, 'linewidth', 3);
% 
% % 
% % 
for j = 0:day24Hours-1
 hold on

%%highlight points greater than 0 hour 

plot3(givenLoadData, j*ones(numel(givenLoadData), 1), pdfLoadValues(j+1, :),'-w','markersize',10, 'linewidth', 3);

end

yticks([0:6:18, 23])
% display ylabel horizontally
hZLabel = get(gca,'ZLabel');
set(hZLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
[caz,cel] = view;
v = [-5 -10 20];
[caz,cel] = view(v);



 print(fig,nameLoad,'-dpng','-r300');


% end of plot surf 

% % generate random pv pow
% % 
% % % Time slot
% minute  = 5;
% tslot = minute/60;
% horizontTslot = day24Hours/tslot;
% numSlotPerHour = horizontTslot/day24Hours;
% tHourIndex = zeros(1, horizontTslot);
% numSlotPerHour = uint8(numSlotPerHour);
% loadGeneratedData = zeros(1, horizontTslot);
% for tslotIndex = 1: horizontTslot
% 
% tHourIndex(tslotIndex) = idivide(tslotIndex-1,numSlotPerHour) + 1;
% % if(tHourIndex(tslotIndex) >= 7 && tHourIndex(tslotIndex)<= 18)
% sigma =std(allPdf(tHourIndex(tslotIndex)).pdfLoad);
% mu = mean(allPdf(tHourIndex(tslotIndex)).pdfLoad);
% sampleSize = 1;
% loadGeneratedData(tslotIndex) = randraw('norm', [mu, sigma], sampleSize);
% % negative value replaced with previous value 
% if( loadGeneratedData(tslotIndex) < 0)
%     loadGeneratedData(tslotIndex) = loadGeneratedData(tslotIndex -1);
% end
% 
% % end
%     
% end
% 
% 
% writematrix(loadGeneratedData.','generated_load_data.xls');
% plot(loadGeneratedData, 'linewidth', 3)
% 
% whitebg('w')
% 
% 
