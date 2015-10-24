function p = predict(theta, X)
%   p = predict(theta, X) computes the predictions for X using a 
%   threshold value at 0.5
p = zeros(size(X, 1), 1);
for i=1:size(X, 1)
	if sigmoid(X(i,:) * theta)>= 0.5 , p(i) = 1;
end;
end