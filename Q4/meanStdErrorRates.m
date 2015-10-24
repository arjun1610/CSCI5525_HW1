function [errorMean, errorStd  ] = meanStdErrorRates( errorMatrix )

%MeanStdErrorRates - Computes the mean and standard deviation of error
%rates for given training percentages
%   Detailed explanation goes here
errorMean=zeros(1, size(errorMatrix,1));
errorStd=zeros(1, size(errorMatrix,1));
for i = 1 : size(errorMatrix,1)
    errorMean(i)= mean(errorMatrix(i,:));
    errorStd(i)=std(errorMatrix(i,:));
end
end

