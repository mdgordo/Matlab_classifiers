
%% trains a naive bayesian classifier on data x with classes c, number of classes nc, and number of histogram bins nk

function Md = naivebayes_train(c,nc,x,nk)
%% creates histogram for each attribute and bins observations
    for i=1:size(x,2)
        H=histogram(x(:,i),nk);
        Hbins=H.BinEdges;
        Var=zeros(size(x,1),1);
        for j=1:nk
            Var(x(:,i)>=Hbins(j) & x(:,i)<Hbins(j+1))=j;
            xp(:,i)=Var;
        end
        Varbins{i}=Hbins;
    end

%% calculate probability of each class
for i=1:nc
    idx=c==i
    n(i)=sum(idx)
end
for i=1:nc
    pc(i)=n(i)/sum(n)
end   

%% for each attribute, calculates cp an ncxnk matrix of conditional probabilities for nc classes and nk histogram bins (w/laplace correction)
    for k=1:size(xp,2)
        %%
        for i=1:nc
            for j=1:nk
                p(i,j)=sum(c==i&xp(:,k)==j);
            end
        end
        %%
        for i=1:nc
            for j=1:nk
                cp(i,j)=(p(i,j)+(1/nc))/(sum(p(:,j))+1);
            end  
        end  
        %%
        cpvar{k}=cp;
        %%
        for j=1:nk
            a(k,j)=sum(xp(:,k)==j);
        end
        for j=1:nk
            ap(k,j)=a(k,j)./sum(a(k,:));
        end
    end
    Md=struct();
    Md.probs = cpvar;
    Md.clprobs = pc
    Md.atprobs = ap;
    Md.varbins = Varbins;
    Md.nk=nk
    Md.nc=nc
end
