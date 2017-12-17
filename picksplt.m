
 function at=picksplt(nodedata,ranges,nodecount,classes,entropy)
 if size(nodedata,2)==0
     at=0
     return
 else if unique(classes)==1
         at=0
         return 
     else for k=1:size(nodedata,2)
            for l=1:ranges(k)
                n{l}=sum(nodedata(:,k)==l);
                d{l}=sum(nodedata(:,k)==l&classes==1);
                Igain(k)=entropy-(n{l}/nodecount)*(d{l}/n{l})*log2(d{l}/n{l});
                [mx, at]=max(Igain);
            end
        end
    end
 end
