function T = bitVector(y)
T = zeros(size(y,1),4);
%creating the vector T which consists of yTrain values as bit vector
%representations
for i = 1 : size(y,1)
    yValue=y(i,1);
    switch yValue
        case 1 
            T(i,:) = [1 0 0 0];
        case 3
            T(i,:) = [0 1 0 0];
        case 7
            T(i,:) = [0 0 1 0];
        case 8
            T(i,:) = [0 0 0 1];
    end;
end;
end