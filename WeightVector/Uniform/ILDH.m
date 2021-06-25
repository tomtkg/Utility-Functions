function W = ILDH(M,H)
%Incremental Lattice Desigin with H specified
    I = M * eye(M);
    W = zeros(1,M);
    edgeW = W;
    for i = 1 : H
        edgeW = repmat(edgeW,M,1) + repelem(I,size(edgeW,1),1);
        edgeW = unique(edgeW,'rows');
        edgeW(min(edgeW,[],2)~=0,:) = [];
        W = [W+1;edgeW];
    end
    W = W / (M*H);
end
