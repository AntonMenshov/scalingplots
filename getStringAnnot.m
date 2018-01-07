function [annot] = getStringAnnot(k,p,q,iterative,letter)
% getStringAnnot - Scaling plot annotation
% Forms string for scaling plot annotation of the form N^p log^q N
% Note, string is formed in LaTeX format, requiring LaTeX interpreter to be
% turned on in the file, where it is being called.
%
% Syntax: annotation = getStringAnnot(k,p,q,iterative)
%
% Inputs:
%    k - scaling coefficient, only 2 decimal places will be taken for string
%    p - power of N
%    q - power of the log
%    iterative - true\false, if true - will add N_it to the end of the annotation
%    letter - which letter to use for (instead of N) 
% Outputs: 
%    annot ? resulting LaTeX formatted string
% 
% Example: 
%     annot = getStringAnnot(19.5E+2,2,3,0);
%             annot = "$1.9\times10^{3}N^{2}\log^{3}NN_{it}$"
% Other m-files required: getMantExpnt.m
% Subfunctions: none
% MAT-files required: none
%
% See also: 
%
% Author: Anton Menshov
% Email: anton.menshov@gmail.com  
% Website: http://antonmenshov.com/


% form the coefficient
[k_m,k_e]=getMantExpnt(k);
num_decimal_places_mantissa=2;
part1=strcat(num2str(k_m,num_decimal_places_mantissa),'\times','10^{',num2str(k_e,3),'}');

% form the polynomial term
if (floor(p)==p) %p is integer
    if (p==1)
        part2=letter;  % no power is required for linear term
    elseif (p==0)
        part2='';   % for a constant scaling even the 'N' itself is not required
    else
        part2=strcat(letter,'^{',num2str(p),'}'); % otherwise the power is written
    end
else
    num_decimal_places_Nscaling=2;
    % if p is not integer, 2 decimal places are used.
    part2=strcat(letter,'^{',num2str(p,num_decimal_places_Nscaling),'}');   
end

% form the logarithmic term
if (q==0) % if power of the log is 0 - no need to add anything to the string
    part3='';
else
    if (q==1)
        part3=strcat('\log {',letter,'}');
    else
        %fractional log powers are not yet supported
        part3=strcat('\log^{',num2str(q),'}',letter); 
    end
end

%add N_it if the scaling is for an iterative method
if (iterative==1)
   part4='N_\mathrm{it}';
else
   part4='';
end

annot=strcat('$',part1,part2,part3,part4,'$');

end