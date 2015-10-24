function [class1,class2,class3,class4]= splitClasses(dataset)
% this function is used to split the dataset into four classes based on the
% values of y
m=size(dataset,1);
j=1;
k=1;
l=1;
n=1;
for i=1:m
    yIndex=dataset(i,1);
    switch(yIndex)
        case 1
            class1(j,:)=dataset(i,:);
            j=j+1;
        case 3
            class2(k,:)=dataset(i,:);
            k=k+1;
        case 7
            class3(l,:)=dataset(i,:);
            l=l+1;
        case 8 
            class4(n,:)=dataset(i,:);
            n=n+1;
    end;
end;
end
            