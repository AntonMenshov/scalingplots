function [mantissa,exponent] = getMantExpnt(arg)
% getMantExpnt 
% Returns mantissa and exponent of a real argument (base-10).
%
% Syntax: [mantissa,exponent] = getMantExpnt(X)
%
% Inputs:
%    arg - argument for which mantissa and exponent have to be computed
%
% Outputs:
%    mantissa, exponent
%
% Example: 
%    [mantissa,exponent]=getMantExpnt(-10.5030E+3);
%        mantissa=-1.050300000000000; exponent=4.
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

exponent = fix(log10(abs(arg)));
mantissa = sign(arg) * 10^(log10(abs(arg))-exponent);

if (abs(mantissa) < 1)
    mantissa = mantissa * 10;
    exponent = exponent - 1;
end

end