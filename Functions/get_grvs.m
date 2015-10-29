function out = get_grvs(mu, covariance, N)
    
    % Generate the random arrays
    out = randn(N,size(covariance,1))*covariance;
    
    % Add in Means
    % First make same size
    mu1 = ones(N,1)*mu(1);
    mu2 = ones(N,1)*mu(2);
    
    out = [out(:,1)+mu1 out(:,2)+mu2];
end