
function AOA(Network,way,Max_iter,solutions_no,N_caps,N_DGs,pf,cap_min,cap_max,DG_min,DG_max,caps_limit,DGs_limit)
%==========================================================================
% rand('seed',0)
%mustafa
%==========================================================================
%                 Archimedes optimization algorithm (AOA)
%==========================================================================
tic
%==========================================================================
Nb=Network.Nb;                                               % No. of buses

% C3=2;C4=.5;                                 %cec and engineering problems
C3=1;C4=1;                                 %standard Optimization functions
%==========================================================================
%                              Initialization
%==========================================================================
C1=.5;
C2=.5;
%==========================================================================
u=.9;  l=.1;                                               %paramter in Eq. (12)


%==========================================================================
% Initial population and Initialization
%==========================================================================
%create the population
% for each device there are two objects: one for the bus and the other for
% the capacity

solutions{solutions_no,2*N_caps+2*N_DGs}=objecte(2,3);
for i=1:solutions_no
    for j=1:N_caps
        solutions{i,j} =objecte(2,Nb);
    end
    
 
    for j=(N_caps+1):(2*N_caps)
        
        solutions{i,j}=objecte(cap_min,cap_max);
    end
    for j=(2*N_caps+1):(2*N_caps+N_DGs)
        
        solutions{i,j} =objecte(2,Nb);
    end
    for j=(2*N_caps+N_DGs+1):(2*N_caps+2*N_DGs)
        
        solutions{i,j} =objecte(DG_min,DG_max);
    end
    for j=(2*N_caps+2*N_DGs+1)
        solutions{i,j} =result(Nb);
    end
end

%==========================================================================
% evaluate the solutions 
%==========================================================================
fitness;
%==========================================================================
% get the best solution (best_obj) of the solutions
%==========================================================================
if way==1
    [min_p, best]=min(p_for_each_solution_for_one_iteration);
    for kk=1:(2*N_caps+2*N_DGs+1)
        best_obj{kk}=solutions{best,kk};
    end
end
if way==2
    [min_TVD, best]=min(TVD_for_each_solution_for_one_iteration);
    for kk=1:(2*N_caps+2*N_DGs+1)
        best_obj{kk}=solutions{best,kk};
    end
end



%==========================================================================
%              Start the iterations -- AOA
%==========================================================================
for t=1:Max_iter
   
    %======================================================================
    TF=exp(((t-Max_iter)/(Max_iter)));                            % Eq. (8)
    if TF>1
        TF=1;
    end
    d=exp((Max_iter-t)/Max_iter)-(t/Max_iter);                    % Eq. (9)
    
    
    for kk=1:solutions_no
        for mm=1:(2*N_caps+2*N_DGs)
            %eq 7
            solutions{kk,mm}.den=(solutions{kk,mm}.den)+rand*((best_obj{mm}.den)-(solutions{kk,mm}.den));
            solutions{kk,mm}.vol =solutions{kk,mm}.vol +rand*(best_obj{mm}.vol- solutions{kk,mm}.vol);
          %collision
            if TF<.55                                                
                mr=randi(solutions_no);
                % Eq. (10)
                solutions{kk,mm}.acc_temp=((solutions{mr,mm}.den+solutions{mr,mm}.vol*solutions{mr,mm}.acc)/(rand*solutions{kk,mm}.vol*solutions{kk,mm}.den));   
                
            else
                %eq 11
                solutions{kk,mm}.acc_temp=((best_obj{mm}.den+best_obj{mm}.vol*best_obj{mm}.acc)/(rand*solutions{kk,mm}.vol*solutions{kk,mm}.den));   % Eq. (10)
                
            end
        end
    end
%==========================================================================
%make a matrix of temp acceleration of all objects
%==========================================================================
    for q=1:solutions_no
        for qq=1:(2*N_caps+2*N_DGs)
            acc_temp(q,qq)=solutions{q,qq}.acc_temp;
        end
    end
    
    
%==========================================================================
% find the minimum and maximum acceleration for each object
%==========================================================================
    for ww=1:(2*N_caps+2*N_DGs)        
        maxe(ww)=max(acc_temp(:,ww));
        mine(ww)=min(acc_temp(:,ww));        
    end
%==========================================================================
% calculate acc_norm for each object
%==========================================================================
    for r2=1:solutions_no
        for rr2=1:(2*N_caps+2*N_DGs)
            %eq 12
            solutions{r2,rr2}.acc_norm=(u*(solutions{r2,rr2}.acc_temp-mine(rr2)))/(maxe(rr2)-mine(rr2))+l;
        end
    end
%==========================================================================
% update position
%==========================================================================
    
    for v3=1:solutions_no
        for vv3=1:(2*N_caps+2*N_DGs)
            if TF<.5
                mr=randi(solutions_no);
                % Eq. (13)
                solutions{v3,vv3}.x=solutions{v3,vv3}.x+C1*rand*solutions{v3,vv3}.acc_norm*(solutions{mr,vv3}.x-solutions{v3,vv3}.x)*d;

            else
                
                
                p=2*rand-C4;                                    % Eq. (15)
                T=C3*TF;
                if T>1
                    T=1;
                end
                
                
                if p<.5
                    % Eq. (14)
                    solutions{v3,vv3}.x=best_obj{vv3}.x+C2*rand*solutions{v3,vv3}.acc_norm*(T*best_obj{vv3}.x-solutions{v3,vv3}.x)*d;
                    
                else
                    solutions{v3,vv3}.x=best_obj{vv3}.x-C2*rand*solutions{v3,vv3}.acc_norm*(T*best_obj{vv3}.x-solutions{v3,vv3}.x)*d;
                end
            end
        end
    end
    
    
    
    
%==========================================================================
% evaluate the solutions 
%==========================================================================
    
    fitness;
    
    
%==========================================================================
% at the end of each iteration
%update the best solution if it is better than the previous
%build the convergence array 
%==========================================================================    
    if way==1            
        [min_p, best]=min(p_for_each_solution_for_one_iteration);
        if (best_obj{2*N_caps+2*N_DGs+1}.Total_PLoss>solutions{best,2*N_caps+2*N_DGs+1}.Total_PLoss)
            for kk=1:(2*N_caps+2*N_DGs+1)
                best_obj{kk}=solutions{best,kk};
            end
        end
        best_p_for_all_iteration(t)=best_obj{2*N_caps+2*N_DGs+1}.Total_PLoss;        
    end
    
        
    if (way==2)        
        [min_TVD, best]=min(TVD_for_each_solution_for_one_iteration);        
        if (best_obj{2*N_caps+2*N_DGs+1}.TVD>solutions{best,2*N_caps+2*N_DGs+1}.TVD)
            for kk=1:(2*N_caps+2*N_DGs+1)
                best_obj{kk}=solutions{best,kk};
            end
        end
        best_TVD_for_all_iteration(t)=best_obj{2*N_caps+2*N_DGs+1}.TVD;        
    end
        
        %draw position for location 1
       
        for cc=1:solutions_no
            beest(cc)=solutions{best,1}.x;
        end
         figure(3)
         if TF<.55
        plot(1:solutions_no,position_location_1,'*r',1:solutions_no,beest)
        axis([0,solutions_no,0,Nb])
         else
        plot(1:solutions_no,position_location_1,'*b',1:solutions_no,beest)
        axis([0,solutions_no,0,Nb])
         end
end
    
    
    final_result
    
