clc
clear 
close all
% opts = detectImportOptions('load.csv');
% preview('load.csv',opts)
% % data = readmatrix()

% opts.Sheet = '2007';
% opts.SelectedVariableNames = [1:5]; 
% opts.DataRange = '2:11';
pvData = readtimetable('load.csv');

l = numel(pvData);

numPVData = 70;
pvDataPerHour = zeros(24, numPVData);
pvTimeHorizon = 1:100;
pvTotalTimeHour = 24*pvTimeHorizon(numPVData);
col = 1;
for t = 1:pvTotalTimeHour

pvDataPerHour(pvData.Date(t, 1).Hour + 1, col) = pvData.Load(t,1);
if mod(t, 24) == 0
    col = col + 1;
end
end

pdfPv = fitdist(pvDataPerHour(1, :)','Normal')

pdfPvValues = pdfPv(pdfArrival,timeHorizon);

nEvTotal=10;
timeHorizon = 0:23;
% arrival pdf 
meamArrivalLb = 4.5;
meamArrivalUb = 9;
meamArrival = (meamArrivalUb-meamArrivalLb).*rand(nEvTotal,1) + meamArrivalLb;

stdArrivalLb = 0.5;
stdArrivalUb = 5;
stdArrival = (stdArrivalUb-stdArrivalUb).*rand(nEvTotal,1) + stdArrivalUb;



pdfArrivalValues= zeros(nEvTotal,max(timeHorizon+1));



for nEv= 1:nEvTotal
pdfArrival = makedist('Normal','mu',meamArrival(nEv),'sigma',stdArrival(nEv));
pdfArrivalValues(nEv, :) = pdf(pdfArrival,timeHorizon);
% figure(nEv);
% plot(timeHorizon,pdfArrivalValues(nEv, :),'LineWidth',2);
end
z = zeros(nEvTotal,max(timeHorizon+1));

for nEv= 1:nEvTotal

z(nEv, :) = repmat(nEv,1,max(timeHorizon+1));

end

h = surf(timeHorizon, 1:nEvTotal, pdfArrivalValues);
c =colorbar
c.Color = 'k';
colormap(spring)
xlabel('Time Horizon')
ylabel('EV ID')
zlabel('PDF')

set(gca,'FontSize',15);
grid on
grid minor
% for x
% set(gca,'XTickLabel',[])
% set(gca,'XTick',[])
set(gca,'xcolor','k') 
set(gca,'ycolor','k')
set(gca,'zcolor','k')
set(gcf,'color','w');
% % for y
% set(gca,'YTickLabel',[])
% set(gca,'YTick',[])
% set(gca,'ycolor','w') 
% % for z
% set(gca,'ZTickLabel',[])
% set(gca,'ZTick',[])
% set(gca,'zcolor','w')