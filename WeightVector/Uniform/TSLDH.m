function W = TSLDH(M,H1,H2)
%Two-layerd Simplex-lattice Desigin with H specified
    W1 = nchoosek(1:H1+M-1,M-1) - repmat(0:M-2,nchoosek(H1+M-1,M-1),1) - 1;
    W1 = ([W1,zeros(size(W1,1),1)+H1]-[zeros(size(W1,1),1),W1])/H1;
    W2 = nchoosek(1:H2+M-1,M-1) - repmat(0:M-2,nchoosek(H2+M-1,M-1),1) - 1;
    W2 = ([W2,zeros(size(W2,1),1)+H2]-[zeros(size(W2,1),1),W2])/H2;
    W  = [W1;W2/2+1/(2*M)];
end
