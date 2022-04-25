clc;
clear all;
% close all;
Networks;


%Network =IEEE_34 or EDN
Network=EDN;
buses_caps= [18 4]
capacities_caps=[1200 630.8]
buses_DGs= [23 21 26]
capacities_DGs=[687.7 1873.1 1439.2]
pf=.9;
[Total_PLoss,Total_QLoss,V_bus,TVD,over_all_power_factor]=BF_gen(Network,buses_caps,capacities_caps,buses_DGs,capacities_DGs,pf)
TVD