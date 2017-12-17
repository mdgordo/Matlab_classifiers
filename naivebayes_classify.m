%% using Md output of naivebayes_train, classifies data y into classes b

function b = naivebayes_classify(Md,y)
    %% Put y's observations into Md's histogram bins
    for i=1:size(y,2)
        Edges=Md.varbins{i};
        Var=zeros(size(y,1),1);
        for j=1:Md.nk
            Var(y(:,i)>=Edges(j) & y(:,i)<Edges(j+1))=j;
            yp(:,i)=Var;
        end
    end

    %% Make a prediction for each observation

    b=zeros(size(y,1),1);
    %%
    for i=1:size(y,1)
        obs=yp(i,:)
        %%
        for j=1:size(y,2)
            attab=Md.probs{j};
            atval=obs(j);
            if atval>0
                classprobs(:,j)=attab(:,atval);
                atprobvec(j)=Md.atprobs(j,atval);
            else
                classprobs(:,j)=attab(:,1);
                atprobvec(j)=Md.atprobs(j,1);
            end
        end
        %% something wrong here - not giving probabilities - attab rows don't add to one?
        for k=1:Md.nc
            pick(k)=prod(classprobs(k,:))*Md.clprobs(k)/prod(atprobvec); 
        end
        %%
        [w,z]=max(pick)
        b(i,1)=z
    end
end
