function example()
    cd(fileparts(mfilename('fullpath')));
    addpath(genpath(cd));
    RNexample();
    WVexample();
    ACexample();
end
function RNexample()
%Random Number example
    names = ["MT","LHS","Grid","Halton","Sobol","Hammersley"];
    rng(1);
    for name = names
        [X,N] = RN(name,2,400);
        var2d(X,[char(name),'XN',num2str(N)]);
        TWVexample(X,char(name));
    end
end
function TWVexample(X,name)
%Transformation to Weight Vector example
    label = ["\lambda_1","\lambda_2","\lambda_3"];
    for i = 1 : 3
       [W,N] = TWV(['Method',num2str(i)],X);
       obj3d(W,[name,'Method',num2str(i),'N',num2str(N)],label);
    end
end
function WVexample()
%Weight Vector example
    label = ["\lambda_1","\lambda_2","\lambda_3"];
    [W,N] = WV('SLD',3,10);    obj3d(W,['SLDN',num2str(N)],label);
    [W,N] = WV('ILD',3,10);    obj3d(W,['ILDN',num2str(N)],label);
    [W,N] = WV('TSLD',3,9);    obj3d(W,['TSLDN',num2str(N)],label);
    [W,N] = WVH('SLD',3,15);   obj3d(W,['SLDN',num2str(N)],label);
    [W,N] = WVH('ILD',3,9);    obj3d(W,['ILDN',num2str(N)],label);
    [W,N] = WVH('TSLD',8,3,1); PCP(W,['TSLDN',num2str(N)]);
end
function ACexample()
%Algorithm Comparison example
    label = ["NSGA-II","MOEA/D","Proopsed"];
    alg = ["NSGAII","MOEAD","MOEADILD"];
    pro = 'DTLZ1_M3_D7';
    FV(label,alg,pro);
    gen = 250;
    TV(label,alg,pro,gen);
    pro = 'DTLZ1_M3_D';
    param = 2 : 10;
    x = 'Number of decision variables \itD';
    PV(label,alg,pro,param,x);
end
