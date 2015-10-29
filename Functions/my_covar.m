function [ C, mean_row ] = my_covar( X )
%computes the covaiance matrix of X
%if X is a row vector, returns the variance
%each column is an observation, each row is a variable

%determine size of the vector
num_rows = length(X(:,1));
num_cols = length(X(1,:));
[a b] = size(X);
%preallocate variables
mean_row = zeros(1,num_rows);
mean_cols = zeros(1,num_cols);
C = zeros(num_rows, num_rows);
%determine the mean of each row and colum
for i = 1:1:num_rows
    mean_row(i) = mean(X(i,:));
end

for j = 1:1:num_cols
    mean_cols(j) = mean(X(:,j));
end
index = 1;
%begin computing covariance matrix
for i = 1:1:num_rows
    for j = 1:1:num_rows
        x = X(i,:)-mean_row(i);
        y = (X(j,:)-mean_row(j))';
        C(i,j) = ((X(i,:)-mean_row(i))*(X(j,:)'-mean_row(j)))/num_cols;  
    end   
end

end