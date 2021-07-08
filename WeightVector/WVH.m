function [W,N] = WVH(method,M,H1,H2)
%Weight Vector with H specified
    if nargin == 3 || H2 == 0
        W = feval(method+"H",M,H1);
    else
        W = feval(method+"H",M,H1,H2);
    end
    W = max(W,1e-6);
    N = size(W,1);
end
