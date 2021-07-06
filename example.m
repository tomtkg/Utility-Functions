function example()
    cd(fileparts(mfilename('fullpath')));
    addpath(genpath(cd));
    RNexample();
    WVexample();
    ACexample();
end
function RNexample()
%Random Number example
    rng(1);
    [X,N] = RN('MT',2,400);
    var2d(X,['MTXN',num2str(N)]);
    [X,N] = RN('LHS',2,400);
    var2d(X,['LHSXN',num2str(N)]);
    [X,N] = RN('Grid',2,400);
    var2d(X,['GridXN',num2str(N)]);
    [X,N] = RN('Halton',2,400);
    var2d(X,['HaltonXN',num2str(N)]);
    [X,N] = RN('Sobol',2,400);
    var2d(X,['SobolXN',num2str(N)]);
    [X,N] = RN('Hammersley',2,400);
    var2d(X,['HammersleyXN',num2str(N)]);
end
function WVexample()
%Weight Vector example
    label = ["\lambda_1","\lambda_2","\lambda_3"];
    [W,N] = WVH('SLD',3,3);
    obj3d(W,['SLDN',num2str(N)],label);
    [W,N] = WVH('ILD',3,2);
    obj3d(W,['ILDN',num2str(N)],label);
    [W,N] = WVH('TSLD',3,2,1);
    obj3d(W,['TSLDN',num2str(N)],label);
    [W,N] = WV('SLD',3,136);
    obj3d(W,['SLDN',num2str(N)],label);
    [W,N] = WV('ILD',3,136);
    obj3d(W,['ILDN',num2str(N)],label);
    [W,N] = WV('TSLD',8,128);
    PCP(W,['TSLDN',num2str(N)]);
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
