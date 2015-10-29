function [ GRV ] = gen_grv(u, stdev, n)
%returns a set of n Gaussian distributed random variables
%u is the desired mean of the set
%stdev is the desired standard deviation of each set
% returns an nx1 vector of random variables

U = rand(n,2);
U1 = U(:,1);
U2 = U(:,2);
Z1 =sqrt(-2.*log10(U1)).*cos(2.*pi.*U2);

for i = 1:length(Z1)
GRV(i) = stdev*Z1(i) + u;
end
%exit gracefully

end