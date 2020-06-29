clc
clear 
close all
rng('default')
% opts = detectImportOptions('load.csv');
% preview('load.csv',opts)
% % data = readmatrix()

% opts.Sheet = '2007';
% opts.SelectedVariableNames = [1:5]; 
% opts.DataRange = '2:11';
pvData = readtimetable('pv.csv');
namePv = 'pvPDF.png';
l = numel(pvData);
day24Hours = 24;
numPvData = 70;
% pvDataPerHour = zeros(24, numPvData);
pvDataPerHour = zeros(24, 1);
pvTimeHorizon = 1:100;

pvTotalTimeHour = 24*pvTimeHorizon(numPvData);
col = 1;
for t = 1:pvTotalTimeHour
pvDataPerHour(pvData.Time(t, 1).Hour+1, col) = pvData.PTotal(t,1);
% pvDataPerHour(pvData.Time(t, 1).Hour) = pvDataPerHour(pvData.Time(t, 1).Hour)+1; 
if mod(t, day24Hours) == 0
    col = col + 1;
end
end




minPvData = 0;
maxPvData = 200;
stepPvData = 10;

givenPvData = minPvData:stepPvData:maxPvData;
pdfPvValues= zeros(day24Hours,numel(givenPvData));

allPdf(day24Hours) = struct();

for nHour= 1:day24Hours
    allPdf(nHour).pdfPv = fitdist(pvDataPerHour(nHour, :)','Normal');
    pdfPvValues(nHour, :) = pdf(allPdf(nHour).pdfPv,givenPvData);
end


timeHorizon =1:day24Hours;
%% Plot pdf
% fig = figure('Name','PV PDF','units','normalized','outerposition',[0 0 0.4 0.45]);
% h = surf(givenPvData, (timeHorizon)-1, pdfPvValues);
% 
% c =colorbar;
% 
% % colormap(spring)
% % colormap(black)
% xlabel('PV Power(kW)')
% ylabel('Time covered(hrs)')
% yticks([6, 8, 10, 12, 14, 16, 17])
% zlabel('PDF')
% 
% set(gca,'FontSize',10);
% % whitebg(40*ones(1,3)/256);
% grid on
% 
% c.Color = 'k';
% set(gca,'xcolor','k') 
% set(gca,'ycolor','k')
% set(gca,'zcolor','k')
% set(gca,'GridAlpha',0.8)
% set(gca,'GridColor','w')
% % set(gca,'MinorGridColor','w')
% set(gca,'GridLineStyle',':')
% 
% set(gcf,'color','w');
% ax = gca; % Get handle to current axes.
% % ax.GridAlpha = 1;  % Make grid lines less transparent.
% % ax.GridColor = 'k'; % Dark Green.
% 
% 
% 
% 
% 
% 
% for j = 0:day24Hours-1
%  hold on
% 
% %%highlight points greater than 0 hour 
% 
% plot3(givenPvData, j*ones(numel(givenPvData), 1), pdfPvValues(j+1, :),'-w','markersize',10, 'linewidth', 3);
% 
% end
% 
% % yticks(5:2:18)
% % display ylabel horizontally
% hZLabel = get(gca,'ZLabel');
% set(hZLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
% [caz,cel] = view;
% v = [-5 -10 20];
% [caz,cel] = view(v);
%   print(fig,namePv,'-dpng','-r300');

% generate random pv pow
% 
% % Time slot

% confidence_interval = .1:.1:.9;
confidence_interval = .8;
for confIndex = 1:size(confidence_interval, 2)
    conf = confidence_interval(confIndex);
    minute  = 5;
    tslot = minute/60;
    horizontTslot = day24Hours/tslot;
    numSlotPerHour = horizontTslot/day24Hours;
    tHourIndex = zeros(1, horizontTslot);
    numSlotPerHour = uint8(numSlotPerHour);
    pvGeneratedData = zeros(1, horizontTslot);
    pvCdfData = zeros(1, horizontTslot);

    for tslotIndex = 1: horizontTslot

        tHourIndex(tslotIndex) = idivide(tslotIndex-1,numSlotPerHour) + 1;
        if(tHourIndex(tslotIndex) >= 7 && tHourIndex(tslotIndex)<= 18)
            sigma =std(allPdf(tHourIndex(tslotIndex)).pdfPv);
            mu = mean(allPdf(tHourIndex(tslotIndex)).pdfPv);
            sampleSize = 1;
            pvGeneratedData(tslotIndex) = randraw('norm', [mu, sigma], sampleSize);

            pvCdfData(tslotIndex) = icdf('Normal',conf,mu,sigma);
            % negative value replaced with previous value 
            if( pvGeneratedData(tslotIndex) < 0)
                pvGeneratedData(tslotIndex) = pvGeneratedData(tslotIndex -1);
            end
            if( pvCdfData(tslotIndex) < 0)
                pvCdfData(tslotIndex) = pvCdfData(tslotIndex - 1);
            end

         end

    end

    fig = figure('Name','Total Power','units','normalized','outerposition',[0 0 1 1]);
    l = horizontTslot;
    namePvConfPic = strcat('generated_pv_', num2str(conf), '_conf.png');
    namePvConfXls = strcat('generated_pv_', num2str(conf), '_conf.xls');
    if confIndex == 1
        writematrix(pvGeneratedData.','generated_pv_data.xls');
    end
    writematrix(pvCdfData.',namePvConfXls);

    p1 = plot(pvGeneratedData, '-rd',...
        'LineWidth',2,...
        'MarkerEdgeColor','r',...
        'MarkerFaceColor','r',...
        'MarkerSize',10);
    hold on
    p2 = plot(pvCdfData, '-bo',...
        'LineWidth',2,...
        'MarkerEdgeColor','b',...
        'MarkerFaceColor','w',...
        'MarkerSize',10);
    p2Name = strcat('PV Confidence:', num2str(conf));
    legend([p1, p2],  'PV Confidence: 1', p2Name);
        xlabel('Time Slot(5 min) 24 --> 2 hours ');
        ylabel('Power(kW)');
        xticks(0 :24: l);

    hYLabel = get(gca,'YLabel');
    set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
    ax = findall(fig, 'type', 'axes');
    set(ax,'FontSize',24)
    % 
    %  print(fig,namePvConfPic,'-dpng','-r300');
end
% % whitebg('w')

