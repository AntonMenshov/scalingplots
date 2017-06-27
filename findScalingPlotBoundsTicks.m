function [minX,maxX,minY,maxY,ticksX,ticksY] = findScalingPlotBoundsTicks(ax)
% findScalingPlotBoundsTicks - nice looking bounds and ticks for scaling plot
% Scaling plot should start at 10^min and 10^max and have ticks every
% decade by default.
%
% Syntax: [minX,maxX,minY,maxY,ticksX,ticksY] = findScalingPlotBoundsTicks(ax)
%
% Inputs:
%    ax - current axes for a figure
%
% Outputs: 
%    minX,maxX,minY,maxY - xlim and ylim for the scaling plots. 
%    ticksX,ticksY - ticks for every decade
% 
% Other m-files required: getMantExpnt.m
% Subfunctions: none
% MAT-files required: none
%
% See also: 
%
% Author: Anton Menshov
% Email: anton.menshov@gmail.com  
% Website: http://antonmenshov.com/

currXlim=get(ax,'xlim');
currYlim=get(ax,'ylim');

[~,expXmin]=getMantExpnt(currXlim(1));
[~,expXmax]=getMantExpnt(currXlim(2));
[~,expYmin]=getMantExpnt(currYlim(1));
[~,expYmax]=getMantExpnt(currYlim(2));

minX=10^expXmin;
maxX=10^expXmax;
minY=10^expYmin;
maxY=10^expYmax;

sizeX=expXmax-expXmin+1;
ticksX=zeros(1,sizeX);
sizeY=expYmax-expYmin+1;
ticksY=zeros(1,sizeY);

k=0;
for i=expXmin:expXmax
    k=k+1;
    ticksX(k)=10^i;
end

k=0;
for i=expYmin:expYmax
    k=k+1;
    ticksY(k)=10^i;
end

end