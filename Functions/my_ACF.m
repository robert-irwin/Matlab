function acf = my_ACF(sig, lags)

check = length(sig)>= lags+1;
if check == 1
    acf = autocorr(sig, lags);
end

if check == 0
  sig1 = sig;
    while check == 0
     sig1 = [sig sig1];
     check = length(sig1)>= lags+1;
    end
end
    acf = autocorr(sig1, lags);
end