function [meanErrorNB,stdErrorNB] = naiveBayesGaussian(filename, num_splits, train_percent)
%% naiveBayesGaussian - function to train and test data using naive bayes 
% with univariate gaussian distribition 

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
        classOnes = size(find(yTrain),1);
        classZeros = size(yTrain,1) - classOnes;
        priorProbabilityOnes = classOnes/size(yTrain,1);
        priorProbabilityZeros = 1- priorProbabilityOnes;
        XTrainZeros = XTrain(1:classZeros,:); % m inputs * n features
        XTrainOnes= XTrain(classZeros+1:end,:); % m inputs * n features
        muZeros=mean(XTrainZeros);
        sigmaZeros=std(XTrainZeros) + 0.001; %adding a small value so that sigma is not zero
        muOnes=mean(XTrainOnes);
        sigmaOnes=std(XTrainOnes) + 0.001;%adding a small value so that sigma is not zero       
        likelihoodZeros=calculateGaussian(XTest,muZeros, sigmaZeros);
        likelihoodOnes=calculateGaussian(XTest,muOnes, sigmaOnes);
        
        for i = 1: size(XTest,1)
            zerosNum=(likelihoodZeros(i,1)* priorProbabilityZeros);
            onesNum=(likelihoodOnes(i,1)* priorProbabilityOnes);
            %compare the likelihood*prior of two classes, which ever is
            %greater assign the predicted value label to that class
            if (zerosNum > onesNum)
                p(i,1)=0;
            else
                p(i,1)=1;
            end
        end;    
            error(trainingIterator,iterations)= mean(double(p ~= yTest))*100;
    end;
end;
[meanErrorNB,stdErrorNB]=meanStdErrorRates(error);
disp('Mean Errors Rates in Percentages: ') 
disp(meanErrorNB);
disp('Standard Deviation Error Rates in Percentages:')
disp(stdErrorNB);
end