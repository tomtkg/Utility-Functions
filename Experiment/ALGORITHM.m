classdef ALGORITHM < handle & matlab.mixin.Heterogeneous
    properties(SetAccess = private)
        parameter = {}; % parameters of the algorithm
        outputFcn;      % function called after each generation
        pro;            % problem solved in current execution
        result;         % populations saved in current execution
        metric;         % metric values of current populations
    end
    methods(Access = protected)
        function obj = ALGORITHM(varargin)
            isStr = find(cellfun(@ischar,varargin(1:end-1)));
            for i = isStr(ismember(varargin(isStr),{'parameter','outputFcn'}))
                obj.(varargin{i}) = varargin{i+1};
            end
        end
    end
    methods(Sealed)
        function Solve(obj,Problem)
            try
                obj.pro = Problem;
                obj.result = {};
                if isequal(obj.outputFcn,@ALGORITHM.EveryGenAll)
                    value = 1:Problem.maxFE/Problem.N;
                    obj.metric = struct('HV',value,'IGD',value);
                elseif isequal(obj.outputFcn,@ALGORITHM.LastGenAll)
                    obj.metric = struct('HV',0,'IGD',0);
                end
                obj.pro.FE = 0;
                addpath(fileparts(which(class(obj))));
                addpath(fileparts(which(class(obj.pro))));
                obj.main(PROBLEM.Current(obj.pro));
            catch err
                if ~strcmp(err.identifier,'PlatEMO:Termination')
                    rethrow(err);
                end
            end
        end
    end
    methods
        function main(~,~)
        end
    end
    methods(Access = protected, Sealed)
        function nofinish = NotTerminated(obj,Population)
            nofinish = obj.outputFcn(obj,Population);
        end
        function varargout = ParameterSet(obj,varargin)
            varargout = varargin;
            specified = ~cellfun(@isempty,obj.parameter);
            varargout(specified) = obj.parameter(specified);
        end
    end
    methods(Static, Sealed)
        function nofinish = EveryGenAll(obj,Population)
            gen = obj.pro.FE/obj.pro.N;
            obj.metric.HV(gen) = HV(Population,obj.pro.optimum);
            obj.metric.IGD(gen) = IGD(Population,obj.pro.optimum);
            nofinish = true;
            if obj.pro.FE >= obj.pro.maxFE
                nofinish = false;
                obj.result = {obj.pro.FE,Population};
            end
        end
        function nofinish = LastGenAll(obj,Population)
            nofinish = true;
            if obj.pro.FE >= obj.pro.maxFE
                nofinish = false;
                obj.metric.HV = HV(Population,obj.pro.optimum);
                obj.metric.IGD = IGD(Population,obj.pro.optimum);
                obj.result = {obj.pro.FE,Population};
            end
        end
    end
end
