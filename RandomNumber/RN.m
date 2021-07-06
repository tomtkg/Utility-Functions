function [X,N] = RN(method,M,N)
%Random Number
    X = feval(method,M,N);
    W = X;
    N = size(W,1);
end
function X = MT(M,N) %Mersenne Twister (used by default stream)
    X = rand([N M]);
end
function X = LHS(M,N)
    X = lhsdesign(N,M);
end
function X = Grid(M,N) %Not Random Number
    gap = linspace(0,1,ceil(N^(1/M)));
    eval(sprintf('[%s]=ndgrid(gap);',sprintf('c%d,',1:M)));
    eval(sprintf('X=[%s];',sprintf('c%d(:),',1:M)));
end
function X = Halton(M,N)
    p = haltonset(M,'Skip',1e3,'Leap',1e2);
    p = scramble(p,'RR2');
    X = net(p,N);
end
function X = Sobol(M,N)
    p = sobolset(M,'Skip',1e3,'Leap',1e2);
    p = scramble(p,'MatousekAffineOwen');
    X = net(p,N);
end
function X = Hammersley(M,N)
    X = [Halton(M-1,N),(1:N)'/N];
end
