function [ S ] = udmirv( n, N, R )
%n is the number of random variables
%N is the total number of samples generated
%R represents the range of the random numbers
%   returns an nx1 vector of random numbers between the range 
%   defined by R = [x y].  
X = zeros(N,1);
S = zeros(N,1);
l =round(N/n);
for i = 1:1:n
    X(:,i) = R(1)+(R(2)-R(1))*rand(N,1);
end
S = sum(X,2);


end
