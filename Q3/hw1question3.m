tic;
clear ; 
close all; 
clc;
dataset='MNIST-1378.csv';
fold=10;
%% Train and Test the data using the FISHER LDA WITH MULTIVARIATE GAUSSIAN DISTRIBUTION
[meanTrainFisher,stdTrainFisher,meanTestFisher,stdTestFisher]=fisher(dataset,fold);
%% Train and test the data using the LEAST SQUARES DISCRIMINANT METHOD
[meanTrainLS,stdTrainLS,meanTestLS,stdTestLS]=sqclass(dataset,fold);
timeSpent=toc;
fprintf('The total execution time of the code to run: %f \n', timeSpent);