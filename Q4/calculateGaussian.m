function [likelihood] = calculateGaussian(X, mu, sigma)
%Calculates the N for the given set of X, mu and sigma
likelihood = zeros(size(X,1),1);
gaussian = zeros(size(X,2),1);
for i= 1: size(X,1)
    conditionalProbability=1;
    for j = 1: size(X,2)
    gaussian(j)= 1/((sqrt(2*pi))* sigma(j)) * exp(-1/2 * ((X(i,j) - mu(j))/ sigma(j))^2);
    %conditional independence of features
    conditionalProbability=conditionalProbability * gaussian(j);
    end
    likelihood(i,1)=conditionalProbability;
end
end
