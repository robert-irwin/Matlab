function [ acf ] = bob_autocorr(sig, numLags, snr )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
acf = autocorr(sig, numLags);
plot(acf)
title(sprintf('Autocorr with %d lags and snr %d dB', numLags, snr));
xlabel('Number of Lags')
end

