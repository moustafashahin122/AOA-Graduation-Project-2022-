
for ii=1:solutions_no
    %make an array of the locations and another for the capacities for the
    %capcitors and another similar array for the DGs
    for jj=1:N_caps
        caps_locations(jj) =round(abs(solutions{ii,jj}.x));
    end
    
    for jj=(N_caps+1):(2*N_caps)
        
        caps_sizes(jj-(N_caps))=solutions{ii,jj}.x;
    end
    for jj=(2*N_caps+1):(2*N_caps+N_DGs)
        
        DGs_locations(jj-(2*N_caps))=round(abs(solutions{ii,jj}.x));
    end
    for jj=(2*N_caps+N_DGs+1):(2*N_caps+2*N_DGs)
        
        DGs_sizes(jj-(2*N_caps+N_DGs))=solutions{ii,jj}.x;
    end
    
    good_solution=true;
    
    
    if (N_caps==0)
        caps_locations=[];
        caps_sizes=[];
    else
        %check some conditions of the capcitors
        min_caps_locations=min(caps_locations);
        max_caps_locations=max(caps_locations);
        min_caps_sizes=min(caps_sizes);
        max_caps_sizes=max(caps_sizes);
        if((min_caps_locations<=1)||(max_caps_locations>=Nb) ||(min_caps_sizes<=cap_min)||(max_caps_sizes>=cap_max))
            good_solution=false;
            solutions{ii,2*N_caps+2*N_DGs+1}.Total_PLoss=inf;
            solutions{ii,2*N_caps+2*N_DGs+1}.TVD=inf;
        end
    end
    if (N_DGs==0)
        
        DGs_locations=[];
        DGs_sizes=[];
    else
        %check some conditions of the DGs
        min_DG_s_locations=min(DGs_locations);
        max_DG_s_locations=max(DGs_locations);
        min_DG_s_sizes=min(DGs_sizes);
        max_DG_s_sizes=max(DGs_sizes);
        if((min_DG_s_locations<=1)||(max_DG_s_locations>=Nb)||(min_DG_s_sizes<=DG_min)||(max_DG_s_sizes>=DG_max))
            good_solution=false;
            solutions{ii,2*N_caps+2*N_DGs+1}.Total_PLoss=inf;
            solutions{ii,2*N_caps+2*N_DGs+1}.TVD=inf;
        end
    end
    
    
    
    
    caps_locations;
    caps_sizes;
    DGs_locations;
    DGs_sizes;
    
    %check conditions
    tot_caps=(sum(caps_sizes));
    tot_DGS=(sum(DGs_sizes));
    if tot_caps>caps_limit
        good_solution=false;
        solutions{ii,2*N_caps+2*N_DGs+1}.Total_PLoss=inf;
        solutions{ii,2*N_caps+2*N_DGs+1}.TVD=inf;
    end 
    if tot_DGS>DGs_limit
        good_solution=false;
        solutions{ii,2*N_caps+2*N_DGs+1}.Total_PLoss=inf;
        solutions{ii,2*N_caps+2*N_DGs+1}.TVD=inf;
    end
    %run BFS Algorithm
    if good_solution
        [Total_PLoss,Total_QLoss,V_bus,TVD,over_all_power_factor]=BF_gen(Network,caps_locations,caps_sizes,DGs_locations,DGs_sizes,pf);
        %save the result of each solution
        solutions{ii,(2*N_caps+2*N_DGs+1)}.Total_PLoss=Total_PLoss;
        solutions{ii,(2*N_caps+2*N_DGs+1)}.Total_QLoss=Total_QLoss;
        solutions{ii,(2*N_caps+2*N_DGs+1)}.V_bus=V_bus;
        mm2=ones(Network.Nb,1);
        solutions{ii,(2*N_caps+2*N_DGs+1)}.TVD=TVD;
%check voltage condition
        
        min_v=min(V_bus);
        max_v=max(V_bus);
        if (min_v<.95) || (max_v>1.05)
            
            solutions{ii,2*N_caps+2*N_DGs+1}.Total_PLoss=inf;
           solutions{ii,2*N_caps+2*N_DGs+1}.TVD=inf;
        end
    end
    %make array of the desired result (ploss or tvd) to update the best
    %solution if it is better than the last solution
    if way ==1
    p_for_each_solution_for_one_iteration(ii)= solutions{ii,2*N_caps+2*N_DGs+1}.Total_PLoss;
    end
    if way==2
        
    TVD_for_each_solution_for_one_iteration(ii)= solutions{ii,(2*N_caps+2*N_DGs+1)}.TVD;

    end
    position_location_1(ii)=solutions{ii,1}.x;
end







