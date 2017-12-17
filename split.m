%% helper function for treetrain, splits a dataset into subsets based on attribute picked by picksplit

 function s=split(ranges,nodedata,attribute,classes)
    for i=1:ranges(attribute)
        idx=nodedata(:,attribute)==i;
        child{i}=nodedata(idx,:);
        child{i}(:,attribute)=[];
        childclasses{i}=classes(idx,:);
        s{1}=child
        s{2}=childclasses
    end
 end
