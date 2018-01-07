% This file demontrates on the example the usage of the package to plot
% scaling curves
clear all; clc; close all;
% set default interpreter
set(groot,'DefaultTextInterpreter','latex');
set(groot,'defaultLegendInterpreter', 'latex');
set(groot,'defaultAxesTickLabelInterpreter','latex'); 

% basic setup (fontsize, markersize, linewidth, etc.)
ff=23;
MyMarkerSize=8;
MyLineWidth=1.0;
BaseAnnotationLineLength=60;
LineWid=0.5;

% Color Definitions
Color_Blue=[0 112 192]./255;
Color_Green=[0 176 80]./255;
Color_Red=[255 0 0]./255;
Color_Purple=[112 48 160]./255;
Color_Orange=[255 192 0]./255;
Color_Pink=[255 0 255]./255;
Color_White=[255 255 255]./255;
Color_Black=[0 0 0]./255;

% Sample N and timing for each of N
N=[9252,13695,22581,40353,75897,146985]';
Timing1=[0.473170707273860*2,0.730474894177520*1.3,1.267680157953044*1.1,2.396579104837460,4.776041987159652,9.793504807599486]';
Timing2=[0.216063822322244*4,0.347880855254563*2.2,0.635416066789659*1.4,1.270836520771937*1.1,2.683450816697996,5.826198033841783]'.*100;
Timing3=[0.004793572224000,0.010502969400000,0.028554487416000,0.091188418104000,0.322579858104000,1.209857052600000]'.*5000;


minN=3; % 10^minN will be the leftmost point on the x-axis
maxN=6; % 10^maxN will be the leftmost point on the x-axis
NumAsympt=1000; %the larger is the number, the smoother is the fitting curve
LogBase=2; % base of the \log for scaling. Scaling is rarely sensitive to it
% the fitting will be performed to the right-most data point if shift is 0.
% if shift is =1 - the fitting line will be performed for the second to the
% left point, etc. Useful, if one needs to understand if he already reached
% the asymptotic behaviour. shift=1 a very reasonable choice.
shift=1; 
n=logspace(minN,maxN,NumAsympt)';

% get the asymptotic line (x -> n, y -> asympt1) and scaling coefficient (k1)
% fitting N\logN for the iterative algorithm
[asympt1,k1]=getAsymptVector(n,1,LogBase,1,N,Timing1,shift);
%obtain a string for annotation
s1_annot=getStringAnnot(k1,1,1,1,'N');

% get the asymptotic line (x -> n, y -> asympt4) and scaling coefficients (c4,k4)
% fitting a 2-term fit for the same plot
[asympt4,c4,k4]=getAsymptVector_2terms(n,0,1,LogBase,1,N,Timing1,shift,shift+3);
%obtain a string for annotation
s4_annot=getStringAnnot_2terms(c4,0,k4,1,1,1,'N');

% get the asymptotic line (x -> n, y -> asympt2) and scaling coefficient (k2)
% fitting N\log^2N for a non-iterative algorithm
[asympt2,k2]=getAsymptVector(n,1,LogBase,2,N,Timing2,shift);
%obtain a string for annotation
s2_annot=getStringAnnot(k2,1,2,0,'N');

% get the asymptotic line (x -> n, y -> asympt2) and scaling coefficient (k2)
% fitting N^2 for a non-iterative algorithm
[asympt3,k3]=getAsymptVector(n,2,LogBase,0,N,Timing3,shift);
%obtain a string for annotation
s3_annot=getStringAnnot(k3,2,0,0,'N');

%% Figure Plotting

figure(1)
% algorithm I timing
% plot asymptotic line
ch1=loglog(n,asympt1,'k-','LineWidth',MyLineWidth);     hold on;
ch4=loglog(n,asympt4,'k--','LineWidth',MyLineWidth);     hold on;
% plot actual data with the markers
p1=loglog(N,Timing1,'x','LineWidth',MyLineWidth,'MarkerSize',MyMarkerSize);hold on;
% customize the look of the plot
p1.Color=Color_Red;
p1.MarkerFaceColor=Color_Red;
% algorithm II timing
% plot asymptotic line
ch2=loglog(n,asympt2,'k-','LineWidth',MyLineWidth);     hold on;
% plot actual data with the markers
p2=loglog(N,Timing2,'o','LineWidth',MyLineWidth,'MarkerSize',MyMarkerSize);hold on;
% customize the look of the plot
p2.Color=Color_Blue;
p2.MarkerFaceColor=Color_White;
% algorithm III timing
% plot asymptotic line
ch3=loglog(n,asympt3,'k-','LineWidth',MyLineWidth);     hold on;
% plot actual data with the markers
p3=loglog(N,Timing3,'s','LineWidth',MyLineWidth,'MarkerSize',MyMarkerSize);hold on;
% customize the look of the plot
p3.Color=Color_Green;
p3.MarkerFaceColor=Color_Green;

ax=gca;
%set the limits
[minX,maxX,minY,maxY,ticksX,ticksY] = findScalingPlotBoundsTicks(ax);
xlim([minX maxX]);
ylim([minY maxY]);
xticks(ticksX);
yticks(ticksY);

% place annotations after the limits (xlim,ylim) have been setup
[x1,y1,x2,y2]=getAnnotationPosition(n,asympt1,0.85,BaseAnnotationLineLength,1.0,2);
annotation('textarrow',[x1,x2],[y1,y2],'interpreter','latex','String',s1_annot,'FontSize',ff-4);
[x1,y1,x2,y2]=getAnnotationPosition(n,asympt4,0.85,BaseAnnotationLineLength,1.0,2);
annotation('textarrow',[x1,x2],[y1,y2],'interpreter','latex','String',s4_annot,'FontSize',ff-4);
[x1,y1,x2,y2]=getAnnotationPosition(n,asympt2,0.5,BaseAnnotationLineLength,1.0,2);
annotation('textarrow',[x1,x2],[y1,y2],'interpreter','latex','String',s2_annot,'FontSize',ff-4);
[x1,y1,x2,y2]=getAnnotationPosition(n,asympt3,0.1,BaseAnnotationLineLength,1.0,1);
annotation('textarrow',[x1,x2],[y1,y2],'interpreter','latex','String',s3_annot,'FontSize',ff-4);

grid on;
ax.FontSize=ff-3;
xlabel('$N$');
ylabel('Time (s)');

% legend
h=legend([p3 p2 p1],{'Algorithm III','Algorithm II','Algorithm I'},'Location','northwest');
h.FontSize=ff-6.;
h.EdgeColor=[1. 1. 1.];
h.Interpreter='none';
