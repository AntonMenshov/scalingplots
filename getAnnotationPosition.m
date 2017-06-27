function [x1norm,y1norm,x2norm,y2norm]=getAnnotationPosition(n,data,offset,length,shift,mode)
% getAnnotationPosition - find the position for the annotation
% using the curve and current axes limits find where to place an annotation
%
% Syntax: [x1norm,y1norm,x2norm,y2norm]=
%                   getAnnotationPosition(n,data,offset,length,shift,mode)
%
% Inputs:
%    n - 
%    data - 
%    offset - (0.0, 1.0) where to place horizontally 
%                        0.1 - almost right border,
%                        0.9 almost left border
%    length - length of the arrow for the annotation
%    shift - how much to raise the text from the fitting line
%    mode - if 1 - places annotation on top of the plot, 2 - underneath it.
%
% Outputs: 
%    x1norm,y1norm,x2norm,y2norm - normalized coordinates that can be used
%    for the 'annotation' Matlab command
% 
% Other m-files required: normalize_coordinate.m
% Subfunctions: none
% MAT-files required: none
%
% See also: 
%
% Author: Anton Menshov
% Email: anton.menshov@gmail.com  
% Website: http://antonmenshov.com/

SizeOut=size(n,1);
if (mode==1) %on top of the fitting line
    x1=n(SizeOut-round(SizeOut*offset)-length);
    x2=n(SizeOut-round(SizeOut*offset));    
    y1=data(SizeOut-round(SizeOut*offset)+length*shift);
    y2=data(SizeOut-round(SizeOut*offset));
end
if (mode==2) %underneath the fitting line
    x1=n(SizeOut-round(SizeOut*offset)+length);
    x2=n(SizeOut-round(SizeOut*offset));    
    y1=data(SizeOut-round(SizeOut*offset)-length*shift);
    y2=data(SizeOut-round(SizeOut*offset));    
end

[x1norm,y1norm]=normalize_coordinate(x1,y1,get(gca,'Position'),get(gca,'xlim'),get(gca,'ylim'),1,1);
[x2norm,y2norm]=normalize_coordinate(x2,y2,get(gca,'Position'),get(gca,'xlim'),get(gca,'ylim'),1,1);

end