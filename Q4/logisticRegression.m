function [meanErrorLR,stdErrorLR] = logisticRegression(filename, num_splits, train_percent)
%% logisticRegression - function to train and test a data using logistic Regression
% this method uses Batch Gradient descent method to find the optimum value
% of theta (which are also the weights).
data = csvread(filename);
X = data(:, 2:size(data,2));
y = data(:, 1);
totalIterations=num_splits;
splitFraction=0.8;
trainMatrix = train_percent;
error=zeros(size(trainMatrix,2),totalIterations);
for iterations=1:totalIterations
    for trainingIterator = 1 : size(trainMatrix,2)
        [XTrain,XTest, yTrain, yTest] = splitData(X, y, splitFraction,trainMatrix(trainingIterator));
        % Normalize the inputs
        [XTrain] = featureNormalize(XTrain);
        [XTest] = featureNormalize(XTest);
        [m, n] = size(XTrain);
        [a, b] = size(XTest);
        % Add intercept term to X_Train and X_test
        XTrain = [ones(m, 1) XTrain];
        XTest = [ones(a, 1) XTest];
        
        theta = zeros(n + 1, 1);
        alpha = 0.1;
        num_iters = 1500;        
        [theta, cost_history] = gradientDescent(XTrain, yTrain, theta, alpha, num_iters);
        p = predict(theta, XTest);
        error(trainingIterator,iterations)= mean(double(p ~= yTest))*100;
    end;
end;
[meanErrorLR,stdErrorLR]=meanStdErrorRates(error);
disp('Mean Errors Rates in Percentages: ')
disp(meanErrorLR);
disp('Standard Deviation Error Rates in Percentages:');
disp(stdErrorLR);
end