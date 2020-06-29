rng(9)
 close all;
 clc;
 clear;
 
 fig = figure('Name','SOC min max','units','normalized','outerposition',[0 0 1 1]);
% arrival 
siz = 500;
% samp = randraw('weibull', [0, 0.9831, 16.8], siz);
% samp = wblrnd(0.9831, 16.8,1, siz);
% histogram(samp);
% bar(samp)

socminl = .04;
socminu = .2;
data1 = (socminu -socminl).*rand(siz,1) + socminl;
pd1 = fitdist(data1, 'Normal');
% pd = makedist('Weibull','a',0.9831,'b',16.8);

samp1 = randraw('norm', [pd1.mu, pd1.sigma], siz);
ind1 = find(samp1 < 0);
samp1(ind1)= 0.01;
edges = [0:.05:1];
h11 = histogram(samp1);
hold on
h1 = histogram(samp1, edges);
%          h1.FaceColor =[58, 227, 32]/256;
%          h1.EdgeColor = 'w';
hold on
x1 = h11.BinLimits(1):.005:h11.BinLimits(2);
ind11 = find(x1 < 0);
x1(ind11)= 0.01;
pdf_weit1 = pdf(pd1,x1);
l1 = min(h1.Values); u1 = max(h1.Values);
pdf_weit1 = rescale(pdf_weit1,l1,u1);
p1 = plot(x1,pdf_weit1,'LineStyle','-',... 
    'Marker', '^',...
    'LineWidth',1,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor','w',...
    'MarkerSize',10,... 
    'color', 'b');
hold on

% % departure 
% siz = 500;
% samp = randraw('weibull', [0, 0.9831, 16.8], siz);
% samp = wblrnd(0.9831, 16.8,1, siz);
% histogram(samp);
% bar(samp)
socmaxl = .89;
socmaxu = .99;
data2 = (socmaxu -socmaxl).*rand(siz,1) + socmaxl;
pd2 = fitdist(data2, 'Normal');
% pd = makedist('Weibull','a',0.9831,'b',16.8);

samp2 = randraw('norm', [pd2.mu, pd2.sigma], siz);
% loadGeneratedData(tslotIndex) = randraw('norm', [mu, sigma], sampleSize)
ind2 = find(samp2 > 1);
samp2(ind2)= 0.99;

h22 = histogram(samp2)
hold on
h2 = histogram(samp2,edges);
%          h2.FaceColor ='r';
           h2.EdgeColor = h2.FaceColor;
           h22.EdgeColor = 'w';
           h1.EdgeColor = h1.FaceColor;
           h11.EdgeColor = 'w';
hold on
x2 = h22.BinLimits(1):.005:h22.BinLimits(2);
ind22 = x2 > 1;
x2(ind22)= 1;
pdf_weit2 = pdf(pd2,x2);



l2 = min(h2.Values); u2 = max(h2.Values);
pdf_weit2 = rescale(pdf_weit2,l2,u2);
p2 = plot(x2,pdf_weit2,':ko',...
    'LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','w',...
    'MarkerSize',10);
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right');
ax = findall(fig, 'type', 'axes');
set(ax,'FontSize',24, 'FontWeight', 'normal')

 legend([h1, p1, h2, p2],  'Minimum SOC Data', 'Minimum SOC Shape',...
                             'Maximum SOC Data','Maximum SOC Shape');   
    
    xlabel('SOC');
    ylabel('Number of EVs');
    xticks(0:.1:1);
