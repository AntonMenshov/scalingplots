function [annot] = getStringAnnot_2terms(c,r,k,p,q,iterative,letter)
% getStringAnnot_2terms - Scaling plot annotation
% Forms string for scaling plot annotation of the form c*N^r + k*N^p log^q N
% Note, string is formed in LaTeX format, requiring LaTeX interpreter to be
% turned on in the file, where it is being called.
%
% Syntax: annotation = getStringAnnot(c,r,k,p,q,iterative,letter)
%
% Inputs:
%    c - scaling coefficient for the first term, only 2 decimal places are used
%    r - power of N in the first term
%    k - scaling coefficient for the second term, only 2 decimal places will be taken for string
%    p - power of N in the second term
%    q - power of the log in the second term
%    iterative - true\false, if true - will add N_it to the end of the annotation
%    letter - which letter to use for (instead of N) 
% Outputs: 
%    annot ? resulting LaTeX formatted string
% 
% Example: 
%     annot = getStringAnnot(5.5E+2,1,19.5E+2,2,3,0,'N');
%             annot = "$5.5\times10^{2}N+1.9\times10^{3}N^{2}\log^{3}{N}N_{it}$"
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
[c_m,c_e]=getMantExpnt(c);
[k_m,k_e]=getMantExpnt(k);
num_decimal_places_mantissa=2;
if (c_e~=0)
    part1_term1=strcat(num2str(c_m,num_decimal_places_mantissa),'\times','10^{',num2str(c_e,3),'}');
else
    part1_term1=strcat(num2str(c_m,num_decimal_places_mantissa));
end
if (k_e~=0)
    part1_term2=strcat(num2str(k_m,num_decimal_places_mantissa),'\times','10^{',num2str(k_e,3),'}');
else
    part1_term2=strcat(num2str(k_m,num_decimal_places_mantissa));
end

% form the polynomial term for the first term
if (floor(r)==r) %r is integer
    if (r==1)
        part2_term1=letter;  % no power is required for linear term
    elseif (r==0)
        part2_term1='';   % for a constant scaling even the 'N' itself is not required
    else
        part2_term1=strcat(letter,'^{',num2str(r),'}'); % otherwise the power is written
    end
else
    num_decimal_places_Nscaling=2;
    % if r is not integer, 2 decimal places are used.
    part2_term1=strcat(letter,'^{',num2str(r,num_decimal_places_Nscaling),'}');   
end

% form the polynomial term for the second term
if (floor(p)==p) %p is integer
    if (p==1)
        part2_term2=letter;  % no power is required for linear term
    elseif (p==0)
        part2_term2='';   % for a constant scaling even the 'N' itself is not required
    else
        part2_term2=strcat(letter,'^{',num2str(p),'}'); % otherwise the power is written
    end
else
    num_decimal_places_Nscaling=2;
    % if p is not integer, 2 decimal places are used.
    part2_term2=strcat(letter,'^{',num2str(p,num_decimal_places_Nscaling),'}');   
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
   part0='(';
   part4=')N_\mathrm{it}';
else
   part0='';
   part4='';
end

annot=strcat('$',part0,part1_term1,part2_term1,'+',part1_term2,part2_term2,part3,part4,'$');

end