function z = cplx(m,p,varargin)
% x = CPLX(m,p): enter a complex number in polar form
%
%   x = CPLX(3,pi/5);
%
%   Allows you to enter a complex number in polar form. The first arguement
%   is the magnitude. The second argument is the phase in radians. An 
%   optional flag allows you to enter the phase angle in degrees:
%
%    x = CPLX(3,25,'deg');
%
%   I. Obeid
%   4/17/2014

if nargin >= 3
    if strcmp(varargin{1},'deg')
        p = p*pi/180;
    else
        error('third input argument not recognized');
    end
end

z = m*exp(1j*p);
