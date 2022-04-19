
%function for capcitors
function [Total_PLoss,Total_QLoss,V_bus,TVD,over_all_power_factor]=BF_gen(Network,buses,capacities,buses1,capacities1,pf)

%==========================================================================
%                              LINE DATA [Ohm]
%==========================================================================
%branch no sending  reciving  R(Ohm)     X(Ohm)
%==========================================================================

LD = Network.lines;

%==========================================================================
%                         BUS DATA [kW and kVar]
%==========================================================================
% bus no     activepower   reactivepower
%              bus_number      P(kw)                     Q(kVAR)
BD = Network.loads;

for i=1:length(buses)
    BD(buses(i),3)=BD(buses(i),3)- capacities(i);
end
for i=1:length(buses1)
    BD(buses1(i),2)=BD(buses1(i),2)- capacities1(i);
    
    BD(buses1(i),3)=BD(buses1(i),3)- capacities1(i)*tan(acos(pf));
end
%==========================================================================
PP = sum(BD(:, 2));
QQ = sum(BD(:, 3));
% fprintf('===========================Power factor=========================')
Power_Factor = cos(atan(QQ / PP));
%==========================================================================
br = length(LD);
no = length(BD);
%==========================================================================
MVAb = 100;
KVb = 11;
Zb = (KVb^2) / MVAb;
%==========================================================================
%                              Per Unit Values
%==========================================================================
R = (LD(:, 4)) / Zb;
X = (LD(:, 5)) / Zb;
P = (BD(:, 2)) ./ (1000 * MVAb);
Q = (BD(:, 3)) ./ (1000 * MVAb);
%==========================================================================
%         Code for  bus-injection to branch-current matrix (BIBC)
%==========================================================================
bibc = zeros(size(LD, 1), size(LD, 1));

for i = 1:size(LD, 1)

    if LD(i, 2) == 1
        bibc(LD(i, 3) - 1, LD(i, 3) - 1) = 1;
    else
        bibc(:, LD(i, 3) - 1) = bibc(:, LD(i, 2) - 1);
        bibc(LD(i, 3) - 1, LD(i, 3) - 1) = 1;
    end

end

S = complex(P, Q); % complex power
Vo = ones(size(LD, 1), 1); % initial bus votage % 10 change to specific data value
S(1) = [];
VB = Vo;
iteration = 100;
% iteration=input('number of iteration : ');
%==========================================================================
for ip = 1:iteration
    %======================================================================
    %                           Backward Sweep
    %=====================================================================
    I = conj(S ./ VB); % injected current
    Z = complex(R, X); %branch impedance
    ZD = diag(Z); %makeing it diagonal
    IB = bibc * I; %branch current
    %======================================================================
    %                           Forward Sweep
    %======================================================================
    TRX = bibc' * ZD * bibc;
    VB = Vo - TRX * I;
end

%==========================================================================
Vbus = [1; VB];
% fprintf('====================Voltage magnitude (p.u.)=====================')
V_bus = abs(Vbus);
V_min= min(V_bus);

I_Line = abs(IB);
%==========================================================================
%                               Power Loss
%==========================================================================
Ibrp = [abs(IB) angle(IB) * 180 / pi];
PLL(1, 1) = 0;
QLL(1, 1) = 0;
% losses
for f2 = 1:size(LD, 1)
    Pl(f2, 1) = (Ibrp(f2, 1)^2) * R(f2, 1);
    Ql(f2, 1) = X(f2, 1) * (Ibrp(f2, 1)^2);
    PLL(1, 1) = PLL(1, 1) + Pl(f2, 1);
    QLL(1, 1) = QLL(1, 1) + Ql(f2, 1);
end

%==========================================================================
%                           Power Loss in each branch
%==========================================================================
%fprintf('===============Active power loss in each branch (kW)=============')
Plosskw = (Pl) * 100000;
%fprintf('=============Reactive power loss in each branch (kVAR)===========')
Qlosskw = (Ql) * 100000;
%==========================================================================
%                              Total Power Loss
%==========================================================================
% fprintf('=================Total active power loss (kW)===================')
Total_PLoss = (PLL) * 100000;
% fprintf('===============Total reactive power loss (kVAR)=================')
Total_QLoss = (QLL) * 100000;
%==========================================================================
v_network=Network.voltages;
% figure(1)
% plot([1:no], V_bus,[1:no],v_network.')
% xlabel('Number of buses')
% ylabel('Voltage magnitude (p.u.)')

 mm1=ones(Network.Nb,1);
TVD=sum((mm1-V_bus).^2);
over_all_power_factor=cos(atan(sum(BD(:,3))/sum(BD(:,2))));
end






