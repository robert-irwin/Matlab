function [ y ] = circonv( h,x )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
N=length(x); y=zeros(N,1);
x=circfold(x,N);
y(1)=h'*x;
for n=2:N
   x=cirshift0(x,1,N);
   y(n)=h'*x;
end

end