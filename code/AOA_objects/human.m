classdef human
    %HUMAN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name 
        age 
        phone
    end
    
    methods
        function human(a,b,c)
            %HUMAN Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = ;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

