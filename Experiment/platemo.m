function platemo(varargin)
    cd(fileparts(mfilename('fullpath')));
    addpath(genpath(cd));
    
    Problem   = getSetting(varargin,'problem',{'N','M','D','maxFE'});
    Algorithm = getSetting(varargin,'algorithm','outputFcn');

    for i = 1 : 31
        rng(i);
        Algorithm.Solve(Problem);
        ResultSave(Algorithm,Problem,i);
    end
end
function Set = getSetting(setting,name,param)
    isStr = find(cellfun(@ischar,setting));
    paramIndex = isStr(ismember(setting(isStr),param));
    input = setting(reshape([paramIndex;paramIndex+1],1,[]));
    
    index = find(strcmp(setting,name),1) + 1;
    if iscell(setting{index})
        input = [input,{'parameter',setting{index}(2:end)}];
        Set = setting{index}{1}(input{:});
    else
        Set = setting{index}(input{:});
    end
end
function ResultSave(alg,pro,r)
    folder   = fullfile('Data',class(alg));
    [~,~]    = mkdir(folder);
    filename = fullfile(folder,sprintf('%s_%s_M%d_D%d_%d.mat',...
        class(alg),class(pro),pro.M,pro.D,r));
    result = alg.result; metric = alg.metric;
    save(filename,'result','metric');
end
