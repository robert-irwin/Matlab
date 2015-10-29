function status = check_significance(mean1, mean2, stdev, n, confidence)
%mean 1 is the expected mean
%mean 2 is the sample mean
% if status = 1, the difference in means is not significant
if (confidence == .8)
     zk_high = 1.28;
     zk_low = -1.28;
elseif (confidence == .9)
    zk_high = 1.645;
    zk_low = -1.645;
elseif (confidence == .95)
    zk_high = 1.96;
    zk_low = -1.96;
elseif (confidence == .99)
   zk_high = 2.58;
   zk_low = -2.58;
elseif (confidence == .999)
    zk_high = 3.08;
    zk_low = -3.08;
end
z = (mean1-mean2)/(stdev/sqrt(n));

if zk_low <= z && z <= zk_high
    status = 1;
else
    status = 0;
end

end