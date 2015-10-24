function [XTrainPercent,XTest, yTrainPercent, yTest] = splitData(X, y, fraction,percentTrain)
% Splits the data into training and testing and returns Test Set Matrix 
% and TrainSet Matrix according to the percentage of training

label = [0;1]; % values of y
%intialize
XTrainTemp= zeros;
yTrainTemp= zeros;
XTrain=zeros;
yTrain=zeros;
XTrainPercent=zeros;
yTrainPercent=zeros;
%split the data according to the fraction given in the input
for i=1:size(label,1)
    temp = (y==label(i,1)); % find out where each label is present
    index = find(temp==1); % get the index of that row where the label is present
    tempX = X(index(:,1),:); % get values of X stored at that particular index
    indexTemp = (randperm(size(tempX,1)))'; % randomly choose rows to put into train
    %find out where the partition index needs to be planted according to
    %the fraction and split the matrix according to the partition index
    partitionIndex=round(size(tempX,1)*fraction);
    XTrainTemp = tempX(indexTemp(1:partitionIndex,1),:);
    XTestTemp = tempX(indexTemp(partitionIndex+1:end),:); % select remaining rows for testing
    yTrainTemp = (ones(size(XTrainTemp,1),1))* label(i,1); 
    yTestTemp = (ones(size(XTestTemp,1),1))* label(i,1);
    
    if i==1
        XTrain = XTrainTemp;
        yTrain = yTrainTemp;
        XTest = XTestTemp;
        yTest = yTestTemp;
    else
        XTrain = [XTrain; XTrainTemp];
        yTrain = [yTrain; yTrainTemp];
        XTest = [XTest; XTestTemp];
        yTest = [yTest; yTestTemp];
    end
end
%Using the percentTrain now to create the Training set according to
%percentage
%This only happens for Training Set, for each split we are not changing any
%test data.
labelOnes=size(find(yTrain),1); 
labelZeros=size(yTrain,1)-labelOnes; 
fracZeros=round(percentTrain*labelZeros/100);
fracOnes=round(percentTrain*labelOnes/100);

XTrainPercent=XTrain(1:fracZeros,:);
OnesIndex=labelZeros+1;
XTrainPercent=[XTrainPercent; XTrain(OnesIndex:labelZeros+fracOnes,:)];
yTrainPercent=zeros(fracZeros,1);
yTrainPercent=[yTrainPercent;ones(fracOnes,1)];
end