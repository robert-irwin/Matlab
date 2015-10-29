function [ y ] = circfold( x,N )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

if length(x) > N; error('N < length(x)');end
x=[x zeros(1,N-length(x))];
n=(0:1:N-1);
y=x(mod(-n,N)+1);

end