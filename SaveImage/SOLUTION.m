classdef SOLUTION < handle
    properties(SetAccess = private)
        dec; obj; con;
    end
    methods
        function v = decs(obj); v = cat(1,obj.dec); end
        function v = objs(obj); v = cat(1,obj.obj); end
        function v = cons(obj); v = cat(1,obj.con); end
    end
end
