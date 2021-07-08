function [W,N] = TWV(method,X)
%Transformation to Weight Vector.
    W = feval(method,X);
    W = max(W,1e-6);
    W = unique(W,'rows');
    N = size(W,1);
end
%Jaszkiewicz's Method
% A. Jaszkiewicz, On the performance of multiple-objective genetic local
% search on the 0/1 knapsack problem - a comparative experiment, in IEEE
% Trans. on Evolutionary Computation, vol. 6, no. 4, pp. 402-412, 2002.
function W = Method1(X)
    [N,A] = size(X);
    W = zeros(N,A+1);%
    W(:,1) = 1 - X(:,1).^(1/A);
    for i = 2 : A
        W(:,i) = (1-sum(W(:,1:i-1),2)).*(1-X(:,i).^(1/(A+1-i)));
    end
    W(:,A+1) =  1 - sum(W,2);
end
%DTLZ Method
% K. Deb, L. Thiele, M. Laumanns, and E. Zitzler, Scalable test problems
% for evolutionary multiobjective optimization, Evolutionary multiobjective
% Optimization. Theoretical Advances and Applications, pp. 105-145, 2005.
function W = Method2(X)
    [N,A] = size(X);
    E = ones(N,1);
    W = fliplr(cumprod([E,X],2)).*[E,1-X(:,A:-1:1)];
end
%Zapotecas-Martínez's Method
% S. Zapotecas-Martínez, H. E. Aguirre, K. Tanaka and C. A. C. Coello,
% On the low-discrepancy sequences and their use in MOEA/D for high-
% dimensional objective spaces, 2015 IEEE CEC pp. 2835-2842, 2015.
function W = Method3(X)
    X = sort(X,2);
    W = [X(:,1),diff(X,1,2),1-X(:,end)];
end
