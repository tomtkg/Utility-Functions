function FV(label,alg,pro)
%Final Value
    HV = zeros(31,size(alg,2));
    IGD = zeros(31,size(alg,2));
    for i = 1 : size(alg,2)
        for j = 1 : 31
            filename = sprintf('Data/%s/%s_%s_%d.mat',alg(i),alg(i),pro,j);
            load(filename,'-mat','metric');
            HV(j,i) = metric.HV(end);
            IGD(j,i) = metric.IGD(end);
        end
    end
    axAlg(HV,pro,label,'Hypervolume');
    axAlg(IGD,pro,label,'IGD');
    for i = 1 : size(alg,2)
        [~,j] = min(abs(HV(:,i)-median(HV(:,i))));
        filename = sprintf('Data/%s/%s_%s_%d.mat',alg(i),alg(i),pro,j);
        load(filename,'-mat','result');
        obj3d(2.*result{2}.objs,[pro,char(alg(i))]); %todo check
    end
end
