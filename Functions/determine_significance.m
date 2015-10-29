function n1 = determine_significance(mean1, mean2, stdev, confidence, n)
%
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
        check = 1;
        n1 = ((zk_high)*stdev/(abs(mean1-mean2)))^2;
    else 
        check = 0;
    end
if check == 0
       n1 = 0;
end

