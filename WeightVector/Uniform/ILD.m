function W = ILD(M,N)
%Incremental Lattice Desigin
    I = M * eye(M);
    W = zeros(1,M);
    edgeW = W;
    while size(W) < N
        edgeW = repmat(edgeW,M,1) + repelem(I,size(edgeW,1),1);
        edgeW = unique(edgeW,'rows');
        edgeW(min(edgeW,[],2)~=0,:) = [];
        W = [W+1;edgeW];
    end
    W = W./sum(W,2);
end
