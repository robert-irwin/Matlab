function [ sig ] = noisy_sin(A, f, d, fs, snr )
%creates a noisy sine wave of duration d, with frequency f, sampled at sf,
%   with signal to noise ratio snr (in dB)
% %test case
% d = 2;
% f = 1;
% sf = 1000;
% A = 1;
% snr = 1;
%construct sine wave
t = 0:1/fs:d;
x = A*sin(2.*pi.*f.*t);
pow_x = (A^2)/2;
%construct noise
A_noise = pow_x/(10^(snr/20));
U = rand(length(x),2);
U1 = U(:,1);
U2 = U(:,2);
Z1 = sqrt(-2.*log(U1)).*cos(2.*pi.*U2);
w = A_noise.*Z1';

%construct signal
sig = x+w;
sig = sig./max(sig);

% plot(t, sig)

%exit gracefully
end