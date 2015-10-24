function error=prediction(X,W,T)
% prediction method for least squares 
predictedY = X * W;
error=ones(size(predictedY,1),1);
for i = 1: size(predictedY,1)
        %which ever value for a given input is larger for a class, assign
        %the label value to that class
        predictedY(i,:)= (predictedY(i,:) == max( predictedY(i,:)));
        if isequal(predictedY(i,:), T(i,:))
            error(i,1)=0;
        end;
end;
