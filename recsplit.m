%%
function nodes=recsplit(node)
    if node.attribute==0
        return
    else    
        splt=split(node.ranges,node.nodedata,node.attribute,node.classes)
        node.children=splt{1}
        node.childclasses=splt{2}
        clear splt
        for j=1:size(node.children,2)
            recsplit(node.children(j))
        end
    end
end
