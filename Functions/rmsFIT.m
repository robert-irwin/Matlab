function [ R2, mean_x, var_x ] = rmsFIT(X, n)
%Returns mean squared error between a data set and a Gaussian Distribution
%of the data set.
%Also plots the gaussian overlayed with a pdf for n=1, n=10, n=100,
%where n is the number of uniformly distributed RVs being summed together.
%if not experimenting with Central Limit Theorem, make n = 1.
%X is the data set
%NBIN represents how many bins to place in the histogram

%find mean and variance
mean_x = mean(X);
var_x = var(X);

X = sort(X);
%define the gaussian
pd = fitdist(X, 'Normal');
gaus = pdf(pd, X);

figure(1)
edges = min(X):.1:max(X);
%edges = R(1)*n:.1:R(2)*n;
h = histogram(X, edges, 'Normalization', 'pdf');
title('all ns')
%correlate the histogram and the gaussian distribution

if((length(gaus)/length(h.Values))>1)
    P = floor(length(gaus)/length(h.Values));
    gaus_avg = downsample(gaus, P);
        for i = 1:length(h.Values)
          dif_square(i) = (h.Values(i)-gaus_avg(i))^2;
        end
%compute the mean squared value
        R2 = sum(dif_square)/length(h.Values);

elseif((length(gaus)/length(h.Values))<1)
    P = floor(length(h.Values)/length(gaus));
    gaus_avg = downsample(h.Values, P);
        for i = 1:length(gaus)
            dif_square(i) = (gaus(i)-gaus_avg(i))^2;
        end
%compute the mean squared value
            R2 = sum(dif_square)/length(gaus);
else
    P = 1;
end
 
if(n == 1)
    figure(2)
    histogram(X, edges, 'Normalization', 'pdf');
    hold on
    plot(X',gaus)
    title('n = 1')
    hold off
    
    elseif(n == 10)
        figure(3)
        histogram(X, edges, 'Normalization', 'pdf');
        hold on
        plot(X',gaus)
       title('n = 10')
        hold off

    elseif(n == 100)
        figure(4)
        histogram(X, edges, 'Normalization', 'pdf');
        hold on
        plot(X',gaus)
        title('n = 100')
        hold off
        
end

  
end
