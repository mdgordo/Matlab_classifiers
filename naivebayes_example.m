%% trains and tests naive bayesian classifier on seed data set

file='seed_data.mat'
data = load(file);

%% set up for full seed_data
x=data.x
c=data.c
nc=data.nc
nk=6

%% leave one out cross validation
for i=1:size(c,1)
    xtemp=x;
    ctemp=c;
    ctemp(i,:)=[];
    xtemp(i,:)=[];
    Md=naivebayes_train(ctemp,nc,xtemp,nk);
    cp(i)=naivebayes_classify(Md,x(i,:));
end
cp=transpose(cp)

%% confusion matrix
confusion=confusionmat(c,cp)
accuracy=trace(confusion)/sum(sum(confusion))
    
%% Train model on full dataset
Md=naivebayes_train(c,nc,x,nk)

%% visualization
A1=Md.probs{1}
%% calculate posteriors
for i=1:nc  
    pc1(i,:)=A1(i,:)*Md.clprobs(i)
end
%% plot
plot(pc1(1,:));
hold on;
plot(pc1(2,:))
plot(pc1(3,:))

title('Distribution of Area of wheat kernel by species')
legend('Kama', 'Rosa', 'Canadian')
xlabel('Area')
ylabel('Probability')
print('attribute1.png', '-dpng')

%% second attribute
A2=Md.probs{2}
for i=1:nc  
    pc2(i,:)=A2(i,:)*Md.clprobs(i)
end  

%% plot
plot(pc2(1,:));
hold on;
plot(pc2(2,:))
plot(pc2(3,:))

title('Distribution of Perimeter of wheat kernel by species')
legend('Kama', 'Rosa', 'Canadian')
xlabel('Perimeter')
ylabel('Probability')
print('attribute2.png', '-dpng')

