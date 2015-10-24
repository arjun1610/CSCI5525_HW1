function [theta, cost_history] = gradientDescent(X, y, theta, alpha, num_iters)
%computes the value of theta and stores the cost in a history table to find
%the convergence 
cost_history = zeros(num_iters, 1);
for iter = 1:num_iters
    [costj, gradj] = gradDescentCost(X, y, theta);
    theta = theta - alpha* gradj;
    cost_history(iter)=costj;
end
end
