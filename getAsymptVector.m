function [asympt,k] = getAsymptVector(points,p,b,q,n,data,shift)
% getAsymptVector - Finds the scaling curve and coeffictions
% Finds the fitting line to a curve of the type k*(N^p log_b^q N)

% Syntax: [asympt,k] = getAsymptVector(points,p,b,q,n,data,shift)
%
% Inputs:
%    points - set of points to evaluate the fit
%    p - power of N
%    b - base of the log: b is LARGER THAN ZERO!
%    q - power of the log : q is LARGER OR EQUAL THAN ZERO!
%    n - sample points of the data
%    data - data to fit
%    shift - the fitting will be performed to the right-most data point if shift is 0.
%            if shift is =1 - the fitting line will be performed for the second to the
%            left point, etc. Useful, if one needs to understand if he already reached
%            the asymptotic behaviour. shift=1 a very reasonable choice.
%
% Outputs: 
%    asympt - vector of sample of the fitted line (y-values)
%    k - fitting coefficient
%
% Example: 
%     [asympt,k] = getAsymptVector([POINTS],1,2,3,[N],[DATA],2);
%             fit a line at [POINTS] to [DATA] corresponding to [N]-values
%             the curve is of the type N log^3 N, base of the log is 2
%             data is fitted to the third point from the right.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: 
%
% Author: Anton Menshov
% Email: anton.menshov@gmail.com  
% Website: http://antonmenshov.com/

N=size(data,1);
SizeOut=size(points,1);
asympt=zeros(SizeOut,1);

if (N-shift<1)
    error('shift exceeds the amount of given data');
end

if ((b<=0)) %if base of the logarithm is accidentally smaller than 0 - ignore log
    M(1,1)=(n(N-shift)^p); 
else
    M(1,1)=(n(N-shift)^p)*(log(n(N-shift))^q)/(log(b)^q);    
end

d(1)=data(N-shift);

AB=linsolve(M,d);
for i=1:SizeOut
    if ((b<=0)) %if base of the logarithm is accidentally smaller than 0 - ignore log
        asympt(i)=AB(1)*(points(i)^p);
    else
        asympt(i)=AB(1)*(points(i)^p)*(log(points(i))^q)/(log(b)^q);
    end
end
k=AB(1);

end