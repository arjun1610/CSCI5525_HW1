tic;
clear ; 
close all; 
clc;
dataset='spam.csv';
train_vector= [5 10 15 20 25 30];
iterations=100;
%% LOGISTIC REGRESSION WITH BATCH GRADIENT DESCENT
[errorMeanLR, errorStdLR]=logisticRegression(dataset, iterations, train_vector);
%% NAIVE BAYES CLASSIFIER WITH UNIVARIATE GAUSSION DISTRIBUTION
[errorMeanNB,errorStdNB]=naiveBayesGaussian(dataset, iterations, train_vector);
%% Plotting the figure here
figure;
hold on;
title('Naive Bayes vs Logistic Regression')
xlabel('Training set percentages');
ylabel('error rates mean and standard deviation');
errorbar(train_vector,errorMeanNB,errorStdNB);
errorbar(train_vector,errorMeanLR, errorStdLR);
legend('Naive Bayes with Univariate Gaussian ','Logistic Regression with Gradient Descent');
axis([0 50 0 50])
hold off;
timeSpent=toc;
fprintf('The total execution time of the code to run: %f \n', timeSpent);