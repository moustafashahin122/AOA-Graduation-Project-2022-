
for jj=1:N_caps
    caps_locations(jj) =round(abs(best_obj{jj}.x));
end

for jj=(N_caps+1):(2*N_caps)
    
    caps_sizes(jj-(N_caps))=best_obj{jj}.x;
end
for jj=(2*N_caps+1):(2*N_caps+N_DGs)
    
    DGs_locations(jj-(2*N_caps))=round(abs(best_obj{jj}.x));
end
for jj=(2*N_caps+N_DGs+1):(2*N_caps+2*N_DGs)
    
    DGs_sizes(jj-(2*N_caps+N_DGs))=best_obj{jj}.x;
end


if (N_caps==0)
    caps_locations=[];
    caps_sizes=[];

    end

if (N_DGs==0)
    DGs_locations=[];
    DGs_sizes=[];
end
    
    [Total_PLoss,Total_QLoss,V_bus,TVD,over_all_power_factor]=BF_gen(Network,caps_locations,caps_sizes,DGs_locations,DGs_sizes,pf);
%==========================================================================
v_network=Network.voltages;
  V_bus;
  caps_locations
  caps_sizes
  caps_tot_size=sum(caps_sizes)
  DGs_locations
  DGs_sizes
  kvar= DGs_sizes*tan(acos(pf))
  DGs_tot_size=sum(DGs_sizes)
  V_min= min(V_bus)
  V_max= max(V_bus)
  Total_PLoss
  Total_QLoss
  over_all_power_factor
figure(1)
plot([1:Nb], V_bus.',[1:Nb],v_network.','r')
xlabel('Buses');
ylabel('Bus Voltages (p.u.)');  
title(' Bus voltages vs Buses');
temp2='Bus voltages';
saveas(gca,temp2);
if way==1
conv=best_p_for_all_iteration.';
end
if way==2
conv=best_TVD_for_all_iteration.';
end
min_conv=min(conv)
if way==1
Total_PLoss;
end
if way==2
TVD;
end
conv
V_bus
[minee,minbus]=min(V_bus)
figure(2)
plot(1:Max_iter,conv)
xlabel('Iteration');
if way==1
ylabel('Total Power loss (KW)');
end
if way==2
ylabel('TVD');
end
title('Convergence curve');
temp1='convergence curve';
saveas(gca,temp1);


    