function example()
    cd(fileparts(mfilename('fullpath')));
    addpath(genpath(cd));
    WVexample();
end

function WVexample()
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
