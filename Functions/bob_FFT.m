function [ Y1 ] = bob_FFT( sig, Fs, snr)
%computes fft of sig sampled at Fs with L points
%also plots each fft from 0 to Fs/2
%snr is signal to noise ratio, an argument for plotting. Make this 1 if 
%not aplicable

T = 1/Fs;
L = length(sig);
%t = (0:L-1)*T


NFFT= 2^nextpow2(Fs);

Y = fft(sig, NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
plot(f,2*abs(Y(1:NFFT/2+1)))
xlabel('Frequency (Hz)');
if(snr ~=1)
title(sprintf('FFT with snr %d dB', snr))
end
Y1 = 2*abs(Y(1:NFFT/2+1));
%exit gracefully
end


