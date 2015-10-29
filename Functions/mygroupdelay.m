function [gd omega] = mygroupdelay(b,a)
% Computation of group delay
% b is num of z-transform
% a is den of z-transform

K = 1024;
omega = 2*pi*(1:K-1)/K;
%first find the poles and zeros of the system
p = roots(a);
z = roots(b);

%find polar representation of poles and zeros
for i = 1:length(z)
    q(i) = abs(z(i));
    theta(i) = angle(z(i));
end
for i = 1:length(p)
    r(i) = abs(p(i));
    phi(i) = angle(p(i));
end    
%implement equation 5.89
syms w
for k = 1:length(p)
    temp(k) = ((r(k)^2)-r(k)*cos(w - phi(k)))/...
        (1+r(k)^2-2*r(k)*cos(w-phi(k)));
end

tgdp = sum(temp);
tgdp = subs(tgdp,omega);
tgdp = eval(tgdp);

for k = 1:length(z)
    tempz(k) = ((q(k)^2)-q(k)*cos(w - theta(k)))/...
        (1+q(k)^2-2*q(k)*cos(w-theta(k)));
end
tgdz = sum(tempz);
tgdz = subs(tgdz,omega);
tgdz = eval(tgdz);

gd = tgdp; - tgdz;


end