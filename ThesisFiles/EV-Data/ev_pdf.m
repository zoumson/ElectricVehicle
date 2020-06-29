clc
close all
clear 
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