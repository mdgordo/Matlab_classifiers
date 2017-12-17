%% trains a decision tree on data x, with classes c, number of classes nc, and range of each class, nx
%% does not work

function tr=treetrain(c,nc,x,nx)

    tr=struct()
%% initialize root node
    root=struct();
    root.nodedata=x;
    root.ranges=nx;
    root.nodecount=size(c,1);
    root.classes=c;
    root.entropy=entropy(root.classes,nc);
    root.attribute=picksplt(root.nodedata,root.ranges,root.nodecount,root.classes,root.entropy);
%% recursively split
    if root.attribute==0
        tr.nodes=root;
    else
        s=split(root.ranges,root.nodedata,root.attribute,root.classes);
        for i=1:numel(s)
            root.child{i}=s{i};
            root.tr=treetrain(s{2}{i},nc,s{1}{i},nx);
        end
    end
end
