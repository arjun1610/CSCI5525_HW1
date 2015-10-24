function error = findError(data,w)
% this function returns the error based on the data set and w calculated from the training set
predictedY=data(:,2:end)*w;
predictedData=[data(:,1) predictedY];
[c1_new,c2_new,c3_new,c4_new]=splitClasses(predictedData);
%covariances of each class
cov_c1x=cov(c1_new(:,2:end));
cov_c2x=cov(c2_new(:,2:end));
cov_c3x=cov(c3_new(:,2:end));
cov_c4x=cov(c4_new(:,2:end));
%mean of each class
mu_c1x=mean(c1_new(:,2:end));
mu_c2x=mean(c2_new(:,2:end));
mu_c3x=mean(c3_new(:,2:end));
mu_c4x=mean(c4_new(:,2:end));

gaussian_c1=gaussian(predictedData(:,2:end),mu_c1x,cov_c1x);
gaussian_c2=gaussian(predictedData(:,2:end),mu_c2x,cov_c2x);
gaussian_c3=gaussian(predictedData(:,2:end),mu_c3x,cov_c3x);
gaussian_c4=gaussian(predictedData(:,2:end),mu_c4x,cov_c4x);

p=zeros(size(predictedData,1),1);

for i=1:size(predictedData,1)
    maximum=max([gaussian_c1(i) gaussian_c2(i) gaussian_c3(i) gaussian_c4(i)]);
    if  maximum == gaussian_c1(i)
        p(i)=1;
    elseif maximum == gaussian_c2(i)
        p(i)=3;
    elseif maximum == gaussian_c3(i)
        p(i)=7;
    elseif maximum == gaussian_c4(i)
        p(i)=8;
    end;
end;
error=mean(p~=data(:,1))*100;
end