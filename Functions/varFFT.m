function [four_Vq, fs] = varFFT(x, t_sig, window1, windowrange, nwnds, overlap, minFs, maxfs)

% Description: Computes the FFT of a signal with a variable sampling rate.
% x is the sampled signal
% t_sig is the time vector associated with that signal

% window1 is an optional argument.  It specifies the type of 
% window to use for a spectrogram.  To dismiss the spectrogram, enter a 'NA' as the
% third argument and 0 or [] for the 4th 5th and 6th argument.  All windows available in Matlab's "window" function
% are available as arguments.

% Window range is a vector whose entries determine the smallest and
% largest window size (1x2) in seconds. nwnds determines the number of desired 
% windows. If windowrange is a 1x1 vector, nwndws is by default 1. 
% Window lengths must integers.  If a floating point value is written to 
% this function, it will be rounded to the nearest integer.

% Overlap is a percentage of the window size.  If overlap is .5 and
% the window length is 2 seconds, the overlap will be 1 second.

% minFs determines if you want to use the minimum sample rate.  This is
% determined by the time vector and the assumption that Nyquist sampling
% theory was not violated.  Enter a 1 for minFs if you want to use
% the minimum sampling frequnecy, otherwise 44.1kHz is used for 
% interpolation.

% maxfs dictates the maximum frequency to plot in the fft and the 
% spectrograms.  If a zero is entered, this defaults to 30Hz.

%check to see what window we are using

if strcmp(window1, 'NA') == 1
    winflag = -1;
elseif strcmp(window1, 'hamming') == 1
    winflag = 0;
elseif strcmp(window1, 'bartlett') == 1
    winflag = 1;
elseif strcmp(window1, 'barthannwin') == 1
    winflag = 2;
elseif strcmp(window1, 'blackman') == 1
    winflag = 3;
elseif strcmp(window1, 'blackmanharris') == 1
    winflag = 4;
elseif strcmp(window1, 'bohmanwin') == 1
    winflag = 5;
elseif strcmp(window1, 'chebwin') == 1
    winflag = 6;
elseif strcmp(window1, 'flattopwin') == 1
    winflag = 7;
elseif strcmp(window1, 'gausswin') == 1
    winflag = 8;
elseif strcmp(window1, 'hann') == 1
    winflag = 9;
elseif strcmp(window1, 'kaiser') == 1
    winflag = 10;
elseif strcmp(window1, 'nutallwin') == 1
    winflag = 11;
elseif strcmp(window1, 'parzenwin') == 1
    winflag = 12;
elseif strcmp(window1, 'rectwin') == 1
    winflag = 13;
elseif strcmp(window1, 'taylorwin') == 1
    winflag = 14;
elseif strcmp(window1, 'tukeywin') == 1
    winflag = 15;
elseif strcmp(window1, 'triang') == 1
    winflag = 16;
else
    error('Invalid window option. Please review the windows abailable  on Matlab''s spectrogram function. Note that every window of version 2015a is available')
end


if winflag ~= -1
    %check windowrange
    [M,N] = size(windowrange);
    if M > 1
        error('windowrange must be a row vector')
    end
    if N > 2
        error('windowrange must be a 1x2 vector with the desired min and max window size')
    end
    if (M == 1) && (N == 1)
        nwnds = 1;
    end
   
    [m, n] = size(nwnds);
    if (m == 1) && (n ==1)
        if (nwnds < 1) || (nwnds > 8)
            error('Number of windows must be between 1 and 8')
        end
    else
        error('nwnds must be a scalar')
    end
    
end

%round numwin
if winflag ~= -1
    nwnds = floor(nwnds);
end
    
% define a sampling frequency
if minFs == 1
    for i = 1:length(t_sig)-1
        fs_vec(i) = 1/(t_sig(i+1)-t_sig(i));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
    end
    %we sample at 5 times the max frequency to be safe 
    fs = 5*max(fs_vec); 
else
    fs = 44100;
end
% define the query points
t_interpol = t_sig(1):1/fs:t_sig(length(t_sig));

%perform the interpolation
Vq = interp1(t_sig,x,t_interpol, 'spline');

L = length(Vq);

NFFT = 2^nextpow2(L);
[four_Vq, f] = myFFT(Vq, fs, NFFT); %compute fourier transform

figure;clf;
%plot(f,2*abs(four_Vq(1:NFFT/2+1)));
plot(f, 2*abs(four_Vq))
title('FFT of Variable Sampled Signal')
xlabel('frequency (Hz)');
ylabel('Magnitude')
if maxfs == 0
    xlim([0 30])
else
    xlim([0 maxfs])
end

if winflag ~= -1 && length(windowrange) == 2
    
    wndwswanted = linspace(windowrange(1), windowrange(2), nwnds);
    %define overlap...
    overlaptime = overlap.*wndwswanted;
    overlapsam = floor(overlaptime.*fs);
% define the window width...
     
    winsam = floor(wndwswanted.*fs);
    
else
    winsam = floor(windowrange*fs);
    overlaptime = overlap*windowrange;
    overlapsam = floor(overlaptime.*fs);
  
end
if winflag ~= 1    
% define the window
    if winflag == 0
        for i = 1:length(winsam)
            win{1,i} = window(@hamming,winsam(i));  
        end
        type = 'Hamming';
    elseif winflag == 1
        for i = 1:length(winsam)
            win{1,i} = window(@bartlett,winsam(i));  
        end
        type = 'Bartlet';
    elseif winflag == 2
        for i = 1:length(winsam)
            win{1,i} = window(@barthannwin,winsam(i)); 
        end
        type = 'Barthann';
        
    elseif winflag == 3
        for i = 1:length(winsam)
            win{1,i} = window(@blackman,winsam(i));  
        end
        type = 'Blackman';
        
    elseif winflag == 4
        for i = 1:length(winsam)
            win{1,i} = window(@blackmanharris,winsam(i));    
        end
        type = 'Blackmanharris';
        
    elseif winflag == 5
        for i = 1:length(winsam)
            win{1,i} = window(@bohmanwin,winsam(i));  
        end
        type = 'Bohman';
        
    elseif winflag == 6
        for i = 1:length(winsam)
            win{1,i} = window(@chebwin,winsam(i)); 
        end
        type = 'Chebyshev';
        
    elseif winflag == 7
        for i = 1:length(winsam)
            win{1,i} = window(@flattopwin,winsam(i)); 
        end
        type = 'Flat Top';
        
    elseif winflag == 8
        for i = 1:length(winsam)
            win{1,i} = window(@gausswin,winsam(i)); 
        end
        type = 'Gaussian';
        
    elseif winflag == 9
        for i = 1:length(winsam)
            win{1,i} = window(@hann,winsam(i));  
        end
        type = 'Hanning';
        
    elseif winflag == 10
        for i = 1:length(winsam)
            win{1,i} = window(@kaiser,winsam(i)); 
        end
        type = 'Kaiser';
        
    elseif winflag == 11
        for i = 1:length(winsam)
            win{1,i} = window(@nutallwin,winsam(i));  
        end
        type = 'Nutall';
        
    elseif winflag == 12
        for i = 1:length(winsam)
            win{1,i} = window(@parzenwin,winsam(i));
        end
        type = 'Parzen';
        
    elseif winflag == 13
        for i = 1:length(winsam)
            win{1,i} = window(@rectwin,winsam(i));    
        end
        type = 'Rectangle';
        
    elseif winflag == 14
        for i = 1:length(winsam)
            win{1,i} = window(@taylorwin,winsam(i));    
        end
        type = 'Taylor';
        
    elseif winflag == 15
        for i = 1:length(winsam)
            win{1,i} = window(@tukeywin,winsam(i)); 
        end
        type = 'Tukey';
        
    elseif winflag == 16
        for i = 1:length(winsam)
            win{1,i} = window(@triang,winsam(i));
        end
        type = 'Triangle';
    end
end
if maxfs == 0
    f = 0:.001:30;
else
    f = linspace(0,maxfs,10e3);
end

if winflag ~= -1
    if nwnds == 1
        figure;
        spectrogram(Vq, win{1,1}, overlapsam, f, fs)
        title(sprintf('Type:%s, Size:%.03f, Overlap:%.03f',type, windowrange, overlaptime))
    else
        figure;
        for i = 1:length(wndwswanted)
            subplot(round(nwnds/2), 2, i)
            spectrogram(Vq, win{1,i}, overlapsam(i), f, fs)
            title(sprintf('Type:%s Size:%.03f Overlap:%.03f sec',type,wndwswanted(i),overlaptime(i)))
        end
    end
end
%exit
end
    