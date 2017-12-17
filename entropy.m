function e=entropy(c,nc)
    for i=1:nc
        class(i)=sum(c==i);
        tot=size(c,1);
        ent(i)=-(class(i)/tot)*log2(class(i)/tot);
    end
    e=sum(ent)
end
