clc;
clear all;
% close all;
Networks;


%AOA(Network,way,Max_iter,solutions_no,N_caps,N_DGs,pf,cap_min,cap_max,DG_min,DG_max,caps_limit,DGs_limit)
%Network =IEEE_34 or EDN
Network=EDN;
%way= 1 for Total_PLoss or 2 for TVD
way=1;
%Max_iter= maximum Number of iterations
Max_iter=50;
%solutions_no=Number of particles
solutions_no=50;
%N_caps=0,1,2,....
N_caps=2;
%N_DGs=0,1,2,.....
N_DGs=3;
%pf= power factor for each DG
pf=.9;
%cap_min= minimum limit for each capcitor
cap_min=200;
%cap_max=maximum limit for each capcitor
cap_max=1200;
%DG_min= minimum limit for each capcitor
DG_min=500;
%DG_max=maximum limit for each capcitor
DG_max=2000;
%caps_limit= maximum limit for the total sizes of the capacitors
caps_limit=4000;
%DGs_limit= maximum limit for the total sizes of the DGS
DGs_limit=4000;
%constants for IEEE_34
if Network.Num==1
%C3=2;C4=.5;   C1=3; C2=6; 
C3=2;C4=.5;   C1=.5; C2=.5; 
end
% constants for EDN
if Network.Num==2
C3=2;C4=.5;   C1=.5; C2=.5;
end
AOA(Network,way,Max_iter,solutions_no,N_caps,N_DGs,pf,cap_min,cap_max,DG_min,DG_max,caps_limit,DGs_limit)