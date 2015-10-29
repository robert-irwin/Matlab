function cFFT(x, Fs)

T = 1/Fs;
L = 1000;
t = (0:L-1)*T


NFFT= 2^nextpow2(L);

Y = fft(x, NFFT)/L
f = Fs/2*linspace(0,1,NFFT/2+1);
figure(1)
plot(f,2*abs(Y(1:NFFT/2+1)))


%exit gracefully
end