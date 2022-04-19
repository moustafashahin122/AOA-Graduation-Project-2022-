classdef objecte
    %OBJECTE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        x;
        den;
        vol;
        acc;
        acc_norm;
        acc_temp;
        
        
    end
    
    methods
        function m= objecte(lb,ub)
            %equ 4:6
            m.x= lb+rand*(ub-lb);
            m.den=rand;
            m.vol=rand;
            m.acc=lb+rand*(ub-lb);
            m.acc_norm=m.acc;
            m.acc_temp=m.acc;
        end

       
    end
    
end


