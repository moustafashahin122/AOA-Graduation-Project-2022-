classdef result
    %RESULT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Total_PLoss=[1]
        Total_QLoss=[1]
        V_bus
        TVD
    end
    
    
    methods
        function obj=result(Nb)
                    Total_PLoss=[1]
        Total_QLoss=[1]
        V_bus=ones(Nb,1)
        TVD=ones(Nb,1)
        end

        

    end
end

