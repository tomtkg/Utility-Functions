function TV(label,alg,pro,gen)
%Transition Value
    HV = zeros(31,gen);  HVTV = zeros(3*size(alg,2),gen);
    IGD = zeros(31,gen); IGDTV = zeros(3*size(alg,2),gen);
    for i = 1 : size(alg,2)
        for j = 1 : 31
            filename = sprintf('%s/%s_%s_%d.mat',alg(i),alg(i),pro,j);
            load(filename,'-mat','metric');
            HV(j,:) = metric.HV;
            IGD(j,:) = metric.IGD;
        end
        HVTV(3*i-2:3*i,:) = quantile(HV,[0.25 0.75 0.5]);
        IGDTV(3*i-2:3*i,:) = quantile(IGD,[0.25 0.75 0.5]);
    end
    for i = 1 : 3
        axGen(i,HVTV,pro,label,'southeast','Hypervolume');
        axGen(i,IGDTV,pro,label,'northeast','IGD');
    end
end
