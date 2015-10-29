function [a0,a,b,coef_c,phase,fxt] = s2f(x, T0, N, astate) 


% 's2f' Plots you function 'x(t)', its fourier series representation and
% Mag/Phase Plots
%
% Formating s2f(x, T0, N- astate)
%
% Input:
% x      = symbolic function (WRT t)
% T0     = Your function x(t)'s Period
% N      = Number of samples to take (optional) [default = 20]
% astate = State the axis value for your Mag/Phase plot. 'h': hertz, 'k':
%           values of k. (optional) [default = 'h' hertz]
%
% Output:
% c      = magnitude of exponential fourier series
% phase  = phase of exponential fourier series
%   See also fft

% Default parameters
if ~exist('N', 'var')
    N = 20;
end
if ~exist('astate', 'var')
    astate = 'h';
end
% Function formating by : Devin Trejo

% Source code from :
% file: quiz_04.m
%
% This file contains a solution for MATLAB quiz no. 4. The quiz can be
% found at:
%
%   www.isip.piconepress.com/courses/temple/ece_3512/exams/2014_fall/quiz_04_v00.docx
%
% Revision History:
%  20140920 (CW): fixed an indexing bug
%  20140919 (BdB): initial version
%

% load the symbolic integration toolbox 
%
syms t n;

% plot the signal
%
figure('name','Plot of x(t)','numbertitle','off');
ezplot(x, [-T0*1.1, T0*1.1]);
temp = axis();
ylim ([-3*temp(4) 3*temp(4)]);
temp = axis();
grid on;

% initialize variables for symbolic integration
%
w0 = 2*pi/T0;
f0 = 1/T0;

% compute the DC value (a0)
%
a0 = (1/T0)*int(x, t, 0, T0);
c(1) = a0;
phase(1) = 0;

% compute the first 20 samples of the Fourier Series:
%  Matlab does not index arrays with zero, everything goes from 1:end. While
%  this may make sense with how we count, it does not do us any favors when
%  it comes to signal processing because zero is very important (and as we
%  all know forgetting about this difference can cause lots of coding
%  troubles, ehm).
%
%  Also, note that we compute the range [-num_samples,num_samples]
%
num_samples = N;
for n = 1 : (num_samples * 2 + 1)

    % re-index the array:
    %  As we want to see the first 20 positive and negative values of k, we
    %  need to iterate 41 times to capture 20 on either side and zero. This
    %  means a q becomes our k as we have to mask it from the true array
    %  index.
    %
    k = n-(num_samples+1);

    % compute a(k)
    %
    coef_a = (2/T0)*int(x*cos(k*w0*t), t, 0, T0);
    a(n) = coef_a*cos(k*w0*t);

    % compute b(k)
    %
    coef_b = (2/T0)*int(x*sin(k*w0*t), t, 0, T0);
    b(n) = coef_b*sin(k*w0*t);

    % convert to a magnitude and phase
    %
    if n ~= 1 
        coef_c(n) = 1/2*(coef_a+j*coef_b);
        c(n) = 1/2*sqrt(coef_a.^2+coef_b.^2);
        phase(n) = atan2(coef_b, coef_a);
    end
end


% plot the magnitude and phase spectrum (Note we need to multiply by 1/2
% since we included negative frequencies in our calculation above
%
figure('name','Fourier Series representation of x(t)','numbertitle','off');
ezplot(0.5*(a0+sum(a)+sum(b)), [-T0*1.1,T0*1.1]);
ylim([temp(3) temp(4)]);
fxt = 0.5*(a0+sum(a)+sum(b));
grid on;
i = linspace(-num_samples/T0, num_samples/T0, n); 

if astate == 'k'
    % label the plot 
    figure('name','Magnitude and Phase','numbertitle','off');
    subplot(211);
    stem(i, c);
    grid on;
    title('Magnitude');
    xlabel('value of k');
    subplot(212);
    stem(i, phase);
    grid on;
    title('Phase');
    xlabel('value of k');
end

if astate == 'h'
    figure('name','Magnitude and Phase (WRT Frequency)','numbertitle','off');
    subplot(211);
    stem(f0*i, c);

    grid on;
    title('Magnitude');
    xlabel('Frequency (Hz)');
    subplot(212);
    stem(f0.*i, phase);
    grid on;
    title('Phase');
    xlabel('Frequency (Hz)');
end



% exit gracefully
%

end
