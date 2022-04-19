clc;
clear all;
close all;
number_of_trials =3

% function [Total_PLoss min_v]=AOA_param(trial_n,max_iter,n_materials,n_capacitors,Q_max,Q_min)
for i=1:number_of_trials
  
 [plos(i), min_v(i)]=case_3_DG_p_Q_param(i,100,100,1,3000,500);
end
figure(3)

[minn,i]= min(plos);
fprintf('minimum total power loss of all trials\n  %3.3f \n',minn)
fprintf('the trial number corresponding to it \n %d \n',i)
stdd= std(plos); 
fprintf('standard deviation\n %3.3f\n',stdd)
plot(1:length(plos),plos)
title('total power loss for each trial  vs trial number')
ylabel('Total power loss (KW)')
xlabel('trial number')
temp1='total power loss for each trial  vs trial number';
saveas(gca,temp1);
figure(4)

[max_v,i]= max(min_v);
fprintf('the maximum voltage of minimum voltages of buses voltages for each trial vs trial number \n %3.3f\n',max_v)
fprintf('trial number corresponding to it \n %d \n',i)
stdd_v= std(min_v);
fprintf('standard deviation \n %3.3f\n',stdd_v)
plot(1:length(min_v),min_v)
title('minimum voltages of buses voltages for each trial vs trial number')
axis([0,length(min_v),.9,1.1])
ylabel('minimum bus voltage for each trial (p.u.)')
xlabel('trial number')
temp2='minimum voltages of buses voltages for each trial vs trial number';
saveas(gca,temp2);