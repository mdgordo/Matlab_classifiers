%% trains and tests CART on leaf dataset using built in fitctree function in Matlab

load('leaf.mat');
   
%% leave one out cross validation
for i=1:size(c,1)
    ctemp=c;
    xtemp=x;
    ctemp(i,:)=[];
    xtemp(i,:)=[];
    M=fitctree(xtemp,ctemp)
    cp(i)=predict(M,x(i,:))
end
cp=transpose(cp)

%% confusion matrix
confusion = confusionmat(c,cp)
imagesc(confusion)
l=colorbar
ylabel(l,'number of observations')
xlabel('predicted class')
ylabel('actual class')
print('confusion1.png','-dpng')

%% accuracy
correct=trace(confusion)
accuracy=correct/size(c,1)

%% 2-fold verification
% create random index
rng(3)
idx=randperm(size(c,1))
ip1=idx(1:size(c,1)/2)
ip2=idx(size(c,1)/2+1:end)
% partition data and classes based on index
prt1=x(ip1,:)
prt2=x(ip2,:)
c1=c(ip1,:)
c2=c(ip2,:)
ctot=[c1;c2]
%fit trees, make predictions
M1=fitctree(prt1,c1)
M2=fitctree(prt2,c2)
cp1=predict(M2,prt1)
cp2=predict(M1,prt2)
ctotp=[cp1;cp2]

%% confusion matrix
conf=confusionmat(ctot,ctotp)
imagesc(conf)
l=colorbar
ylabel(l,'number of observations')
xlabel('predicted class')
ylabel('actual class')
print('confusion2.png','-dpng')

%% accuracy
correct=trace(conf)
accuracy=correct/size(c,1)

%% 17-fold verification
% create random index
rng(3)
idx=randperm(size(c,1))
for i=1:17
    start=((i-1)*size(c,1)/17)+1
    fin=i*size(c,1)/17
    ip(i,:)=idx(start:fin)
end
%% partition data and classes based on index
for i=1:17
    xtemp=x;
    xtemp(ip(i,:),:)=[];
    prt{i}=xtemp
    ctemp=c;
    ctemp(ip(i,:),:)=[];
    cprt{i}=ctemp
    ctest{i}=c(ip(i,:),:)
    xtest{i}=x(ip(i,:),:)
end
%%
%fit trees, make predictions
for i=1:17
    M17{i}=fitctree(prt{i},cprt{i})
    c17{i}=predict(M17{i},xtest{i})
end

preds=[c17{1};c17{2};c17{3};c17{4};c17{5};c17{6};c17{7};c17{8};c17{9};c17{10};c17{11};c17{12};c17{13};c17{14};c17{15};c17{16};c17{17}]
acts=[ctest{1};ctest{2};ctest{3};ctest{4};ctest{5};ctest{6};ctest{7};ctest{8};ctest{9};ctest{10};ctest{11};ctest{12};ctest{13};ctest{14};ctest{15};ctest{16};ctest{17}]

%% confusion
conf3=confusionmat(acts,preds)
imagesc(conf3)
l=colorbar
ylabel(l,'number of observations')
xlabel('predicted class')
ylabel('actual class')
print('confusion3.png','-dpng')

%% accuracy
correct=trace(conf3)
accuracy=correct/size(c,1)

%% full tree
M=fitctree(x,c)
view(M,'mode','graph')
