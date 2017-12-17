function b=treeclassify(y,tr)

for i=1:size(y,1)
    node=tr.nodes{1}
    at=node.attribute
    if at==0
        b=root.chat
    else v=y(i,at)
        at=node.child{v}
        node=node.child{v}
end
