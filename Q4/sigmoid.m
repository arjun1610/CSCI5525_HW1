function gx = sigmoid(z)
%Computes sigmoid functoon
gx = zeros(size(z));
gx = 1 ./ (1+ exp(-1 .* z));
end
