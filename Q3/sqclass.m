function [meanTrain,stdTrain,meanTest,stdTest]=sqclass(filename,num_crossval)
%divide the data according to the folds given
data=csvread(filename);
fold=num_crossval;
index=partitionDataIndex(data,fold); % folds * partition size
for j=1:fold
    %divide the data indexes and fetch the train and test set in such a way
    %that it takes n equal partitions and form a test set of 1 partition
    %and a training set fo remaining n-1 partitions
    TestSet=data(index(j,:),:);
    TrainSet=data(index(~ismember(1:fold,j),:),:);
    
    XTrainSet = TrainSet(:,2:size(TrainSet,2));
    yTrainSet = TrainSet(:, 1);
    XTestSet= TestSet(:,2:size(TrainSet,2));
    yTestSet=TestSet(:,1);
    %convert the labels of the classes into bit vector representations
    TTrain=bitVector(yTrainSet);
    %calculate W for each XTrain inputs
    % Here optimal W value = inv(X'X)X'T
    % add intercept 1 to training set X 
    XTrainSet=[ones(size(XTrainSet,1),1) XTrainSet];
    leastsquares= XTrainSet' * XTrainSet;
    %adding this value epsilon to the matrix leastsquares so that the
    %matrix is non-singular
    epsilon=0.0001;
    a=eye(size(leastsquares));
    a=a*epsilon;
    leastsquares = leastsquares + a;
    W= inv(leastsquares) * XTrainSet' * TTrain;
    %Train the W and Test it on TestSet
    TTest=bitVector(yTestSet);
    XTestSet=[ones(size(XTestSet,1),1) XTestSet];
    errorTrain=prediction(XTrainSet,W,TTrain);
    errorTest=prediction(XTestSet,W,TTest);    
    %compute the error fraction and get the percentages
    errorTrain_m(j,1)=mean(errorTrain)*100;
    errorTest_m(j,1)=mean(errorTest)*100;
    meanTrain=mean(errorTrain_m);
    stdTrain=std(errorTrain_m);
    meanTest=mean(errorTest_m);
    stdTest=std(errorTest_m);
end;
disp('Mean Train Errors Rates in Percentages: ')
disp(meanTrain);
disp('Standard Deviation Train Error Rates in Percentages');
disp(stdTrain);
disp('Mean TestErrors Rates in Percentages: ')
disp(meanTest);
disp('Standard Deviation Test Error Rates in Percentages');
disp(stdTest);
end