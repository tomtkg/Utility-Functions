function [W,N] = WV(method,M,N)
%Weight Vector
    W = feval(method,M,N);
    W = max(W,1e-6);
    N = size(W,1);
end
