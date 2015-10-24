function gaussianValues = gaussian (X, mu, cov)
% given the dataset, covariance matrix, mean of input values, it computes
% the gaussian of the dataset, returns the number of inputs by 1 matrix
a= size(X,1);
Xmu= X - repmat(mu,[a,1]);
gaussianValues=zeros(a,1);
for i =1:a
    gaussianValues(i,1)=(1/sqrt(det(cov) * (2*pi)^3)) * exp(-1/2 * Xmu(i,:) * inv(cov) * Xmu(i,:)');
end
end