function [X_normalize] = featureNormalize(X)
% takes the input X and returns all the elements in the form of (X-mu)/sigma
X_normalize = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));
mu=mean(X);
sigma=std(X);
for i=1:size(X,2)
    X_normalize(:,i)= (X(:,i) - mu(i))./ sigma(i);
end
end
