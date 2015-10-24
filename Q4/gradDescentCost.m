function [cost, grad] = gradDescentCost(X, y, theta)
% gradDescentCost function computes the cost and gradient for logistic 
% regression using theta as the parameter
% the function returns the gradient and the cost to be used by theta for
% further calculations
m = length(y); % number of training examples
cost = 0;
grad = zeros(size(theta));
h= sigmoid ( X * theta );
grad = (1 / m) .* ( X' * ( h - y ) );
cost = (1/m) * sum( -y .* log(h) - (1-y) .* log(1-h));
end
