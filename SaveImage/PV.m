function PV(label,alg,pro,param,x)
%Parameter Value
    HV = zeros(31,1);  HVPV = zeros(3*size(alg,2),size(param,2));
    IGD = zeros(31,1); IGDPV = zeros(3*size(alg,2),size(param,2));
    for h = 1 : size(param,2)
        for i = 1 : size(alg,2)
            for j = 1 : 31
                filename = sprintf('Data/%s/%s_%s%d_%d.mat', ...
                    alg(i),alg(i),pro,param(h),j); %todo check
                load(filename,'-mat','metric');
                HV(j) = metric.HV(end);
                IGD(j) = metric.IGD(end);
            end
            HVPV(3*i-2:3*i,h) = quantile(HV,[0.25 0.75 0.5]);
            IGDPV(3*i-2:3*i,h) = quantile(IGD,[0.25 0.75 0.5]);
        end
    end
    axParam(param,HVPV,pro,label,'southwest','Hypervolume',x);
    axParam(param,IGDPV,pro,label,'northwest','IGD',x);
    axParam(param,HVPV./HVPV(3,:),['2',pro,],label,'southwest','Hypervolume',x);
    axParam(param,IGDPV./IGDPV(3,:),['2',pro],label,'northwest','IGD',x);
end
