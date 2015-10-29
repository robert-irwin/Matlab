function varPrint(x,varargin)
% varPrint(x): prints the name of a variable and its value
%
%   Usage example:
%      foo = 2.2;
%      varPrint(foo)
%   returns
%      foo = 2.200000
%
%   Also includes support for complex numbers which print in rectangular
%   form by default. You can supply an optional input flag of either 'pol'
%   or 'polar' to force a complex output to be displayed in polar form.
%   Alternately, use 'pold' to get polar in degrees
%
%   Usage example:
%      foo = 2.2 + 3.3i;
%      varPrint(foo)
%   returns
%      foo = 2.200000 +3.300000j
%   and
%      varPrint(foo,'pol) OR
%      varPrint(foo,'polar')
%   returns
%      foo = 3.966106 < 0.982794
%
%   Also includes support for vectors but not matrices
%
%  I. Obeid 03/20/2014


global flag1 varName
varName = inputname(1);

% this is the acceptable list of input flags
flag1_list = {'','rect','rec','pol','polar','pold'};

% collect any input flags
flag1 = '';
if nargin>1
    flag1 = varargin{1};
end

% check to see if input flag is in the list, otherwise throw an erorr and
% terminate
if ~(ismember(lower(flag1) , flag1_list))
    error('varPrint: "%s" is not a valid input\n',flag1);
end

if numel(x) == 1
    x_single(x);
elseif isvector(x)
    x_vector(x);
else
    error('varPrint: your variable cannot be a 2D matrix');
end

% IF X IS A SINGLE VALUE
function x_single(x)
global flag1 varName
% print the variable name under one of three conditions
if isreal(x)
    % x is real
    fprintf('%s = %f\n',varName,x);
elseif (any (strcmpi(flag1 , {'pol','polar'}) ) )
    % x is complex and polar form (radians) has been specified
    fprintf('%s = %f < %f\n',varName,abs(x),angle(x));
elseif (any (strcmpi(flag1 , {'pold'} ) ) )
    % x is complex and polar form (degrees) has been specified
    fprintf('%s = %f < %f\n',varName,abs(x),angle(x)*180/pi);
else
    % x is complex and rectangular form has been specified (or left to the
    % default)
    fprintf('%s = %f %+fj\n',varName,real(x),imag(x));
end

% IF X IS A VECTOR
function x_vector(x)
global flag1 varName
fprintf('%s =\n',varName);
% print the variable name under one of three conditions
if all(isreal(x))
    % x is real
    for i = 1:length(x)
        fprintf('%i\t%10f\n',i,x(i));
    end
elseif (any (strcmpi(flag1 , {'pol','polar'}) ) )
    % x is complex and polar form (radians) has been specified
    for i = 1:length(x)
        fprintf('%i\t%7.2f < %7.2f\n',i,abs(x(i)),angle(x(i)));
    end
elseif (any (strcmpi(flag1 , {'pold'} ) ) )
    % x is complex and polar form (degrees) has been specified
    for i = 1:length(x)
        fprintf('%i\t%7.2f < %7.1f\n',i,abs(x(i)),angle(x(i))*180/pi);
    end
else
    % x is complex and rectangular form has been specified (or left to the
    % default)
    for i = 1:length(x)
        fprintf('%i\t%7.2f %+7.2fj\n',i,real(x(i)),imag(x(i)));
    end
end
