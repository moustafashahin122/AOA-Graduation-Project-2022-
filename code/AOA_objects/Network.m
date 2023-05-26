classdef Network
    %NETWORK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        lines;
        loads;
        voltages;
        Nb;
        % Num;
    end
    
    methods
        function obj = Network(lines,loads,voltages,Nb,Num)
            %NETWORK Construct an instance of this class
            %   Detailed explanation goes here
            obj.lines = lines;
            obj.loads=loads;
            obj.voltages=voltages;
            obj.Nb=Nb;
            % obj.Num=Num;
        end

    end
end

