function [asympt,c,k] = getAsymptVector_2terms(points,r,p,b,q,n,data,shift1,shift2)
% getAsymptVector - Finds the scaling curve and coeffictions
% Finds the fitting line to a curve of the type c*N^r+k*(N^p log_b^q N)

% Syntax: [asympt,c,k] = getAsymptVector(points,r,p,b,q,n,data,shift1,shift2)
%
% Inputs:
%    points - set of points to evaluate the fit
%    r - power of N in the first term
%    p - power of N in the second term
%    b - base of the log: b is LARGER THAN ZERO!
%    q - power of the log in the second term : q is LARGER OR EQUAL THAN ZERO!
%    n - sample points of the data
%    data - data to fit
%    shift1,shift2 - the fitting will be performed to the right-most data point if shift is 0.
%            if shift is =1 - the fitting line will be performed for the second to the
%            left point, etc. shift1=1,shift2=2 is a very reasonable choice.
%            For this version of the fitting, shift1 should not be equal to
%            shift2, otherwise trying to fit two terms to only one point
%
%
% Outputs: 
%    asympt - vector of sample of the fitted line (y-values)
%    c - fitting coefficient for the first term
%    k - fitting coefficient for the second term
%
% Example: 
%     [asympt,c,k] = getAsymptVector([POINTS],1,1,2,3,[N],[DATA],2,2);
%             fit a line at [POINTS] to [DATA] corresponding to [N]-values
%             the curve is of the type N + N log^3 N, base of the log is 2
%             data is fitted to the third point from the right for both
%             terms
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

if (shift1==shift2)
    error('shifts are identical');
end

N=size(data,1);
SizeOut=size(points,1);
asympt=zeros(SizeOut,1);

if (N-shift1<1)
    error('shift1 exceeds the amount of given data');
end
if (N-shift2<1)
    error('shift2 exceeds the amount of given data');
end

M=zeros(2,2);
d=zeros(2,1);

if ((b<=0)) %if base of the logarithm is accidentally smaller than 0 - ignore log
    M(1,1)=n(N-shift1)^r;
    M(1,2)=n(N-shift1)^p;
    M(2,1)=n(N-shift2)^r;
    M(2,2)=n(N-shift2)^p;
else
    M(1,1)=n(N-shift1)^r;
    M(1,2)=n(N-shift1)^p*(log(n(N-shift1))^q)/(log(b)^q);
    M(2,1)=n(N-shift2)^r;
    M(2,2)=n(N-shift2)^p*(log(n(N-shift2))^q)/(log(b)^q);   
end

d(1)=data(N-shift1);
d(2)=data(N-shift2);

AB=linsolve(M,d);

if (AB(1)<0 || AB(2)<0)
    error('Failure to fit. Negative fitting coeffitients.');
end

for i=1:SizeOut
    if ((b<=0)) %if base of the logarithm is accidentally smaller than 0 - ignore log
        asympt(i)=AB(1)*(points(i)^r)+AB(2)*(points(i)^p);
    else
        asympt(i)=AB(1)*(points(i)^r)+AB(2)*(points(i)^p)*(log(points(i))^q)/(log(b)^q);
    end
end

c=AB(1);
k=AB(2);

end