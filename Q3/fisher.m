function [meanTrain,stdTrain,meanTest,stdTest]=fisher(filename,num_crossval)
%% This function trains and test the dataset using the fisher linear discriminant analysis 
%classifier, which is followed by Multivariate Gaussian generative modeling

%read the data
data=csvread(filename);
fold=num_crossval;
%define folds for the number
%divide the data according to the folds given
partitionIndex=partitionDataIndex(data,fold); % folds * partition size
for j=1:fold
    %divide the data indexes and fetch the train and test set in such a way
    %that it takes n equal partitions and form a test set of 1 partition
    %and a training set fo remaining n-1 partitions        
    TestSet=data(partitionIndex(j,:),:);
    TrainSet=data(partitionIndex(~ismember(1:fold,j),:),:);
    %divide the Set by the classes 
    [c1,c2,c3,c4]=splitClasses(TrainSet);
    %Computes the mean of each class (1xD)
    m1=mean(c1(:,2:end));
    m2=mean(c2(:,2:end));
    m3=mean(c3(:,2:end));
    m4=mean(c4(:,2:end));
    %computes the within class variances by calculate each class 
    XminusMu1=c1(:,2:end)-repmat(m1,[size(c1,1),1]);
    S1=XminusMu1'*XminusMu1;
    XminusMu2=c2(:,2:end)-repmat(m2,[size(c2,1),1]);
    S2=XminusMu2'*XminusMu2;
    XminusMu3=c3(:,2:end)-repmat(m3,[size(c3,1),1]);
    S3=XminusMu3'*XminusMu3;
    XminusMu4=c4(:,2:end)-repmat(m4,[size(c4,1),1]);
    S4=XminusMu4'*XminusMu4;
    S_W=S1+S2+S3+S4;
    %compute the mean of total inputs
    m=mean(TrainSet(:,2:end));
    XminusM= TrainSet(:,2:end)-repmat(m,[size(TrainSet,1),1]);
    S_T=XminusM'*XminusM;
    S_B=S_T-S_W;
    %     add epsilon 0.0001 to make the matrix non-singular
    epsilon=0.001;
    a=eye(size(S_W));
    a=a*epsilon;
    S_W=S_W + a;
    S_Winv=inv(S_W);
    multi=S_Winv * S_B;
    [eig_vector,eig_values]=eig(multi);
    % find the largest eigen values
    [~,index] = sort(diag(eig_values),1,'descend');
    % select the eigen vectors according to the eigen values (top 3) here (
    % K-1 is the rank of the matrix here (explained in the FAQs of HW1)
    w=eig_vector(:,index(1:3));
    %compute error rates on train and test data
    errorTrain(j,1) = findError(TrainSet,w);
    errorTest(j,1) = findError(TestSet,w);    
end

meanTrain=mean(errorTrain);
stdTrain=std(errorTrain);
meanTest=mean(errorTest);
stdTest=std(errorTest);
disp('Mean Train Errors Rates in Percentages: ')
disp(meanTrain);
disp('Standard Deviation Train Error Rates in Percentages');
disp(stdTrain);
disp('Mean TestErrors Rates in Percentages: ')
disp(meanTest);
disp('Standard Deviation Test Error Rates in Percentages');
disp(stdTest);
end