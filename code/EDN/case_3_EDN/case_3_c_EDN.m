clc;
clear all;

%==========================================================================
%rand('seed',0)
%==========================================================================
%                 Archimedes optimization algorithm (AOA)
%==========================================================================
tic
%==========================================================================
Nb=30;                                                       % No. of buses
%==========================================================================
Materials_no=100;                                      % Number of Particles                               
dim=4;                                        % Number of control varaibles
Max_iter=100;                                % Maximum number of iterations
%==========================================================================
% C3=2;C4=.5;                                 %cec and engineering problems
C3=1;C4=2;                                 %standard Optimization functions
%==========================================================================
Qc_min=150;                                    % Minimum limit of capacitor
Qc_max=1200;                                   % Maximum limit of capacitor
%==========================================================================
bounds=[Qc_min*ones(Nb,1)  Qc_max*ones(Nb,1)];
%==========================================================================
nv=size(bounds,1);                                       % No. of variables
L=bounds(:,1)';                                          % Lower boundaries
Lmax=L([ones(Materials_no,1)],1:nv);
H=bounds(:,2)';                                          % Upper boundaries
Hmax=H([ones(Materials_no,1)],1:nv);
rang=H-L;
%==========================================================================
% Initial population
%==========================================================================
for k=1:Materials_no;
    for j=1:dim;
        x1(k,j)=L(j)+rand*rang(j);            
    end
end 
x1;                                                  % Sizing of Capacitors
%==========================================================================
bounds1=[2*ones(Nb,1)  Nb*ones(Nb,1)];
%==========================================================================
nv1=size(bounds1,1);                                       % No. of variables
L1=bounds1(:,1)';                                          % Lower boundaries
Lmax1=L1([ones(Materials_no,1)],1:nv);
H1=bounds1(:,2)';                                          % Upper boundaries
Hmax1=H1([ones(Materials_no,1)],1:nv);
rang1=H1-L1;
%==========================================================================
% Initial population
%==========================================================================
for k=1:Materials_no;
    for j=1:dim;
        x2(k,j)=L1(j)+rand*rang1(j);            
    end
end 
x2;                                                 % Sitting of Capacitors
%==========================================================================
%                              Initialization
%==========================================================================
C1=0.5;
C2=0.5;
%==========================================================================
u=.9;                                                 %paramter in Eq. (12)
l=.1;                                                 %paramter in Eq. (12)
X=[x2 x1];                                       %initial positions Eq. (4)
den=rand(Materials_no,2*dim);                                       % Eq. (5)
vol=rand(Materials_no,2*dim);
ss1=2*ones(Materials_no,dim)+rand(Materials_no,dim)*(Nb-2);
ss2=Qc_min*ones(Materials_no,dim)+rand(Materials_no,dim)*(Qc_max-Qc_min);
acc=[ss1 ss2];                                                    % Eq. (6)
%==========================================================================
%                         Objective Function
%==========================================================================
bvar1=round(X(:,1:dim));                % Capacitor Locations (0 off, 1 on)
bvar2=X(:,dim+1:2*dim);                           % Capacitor Sizing (KVAR)
bvar3=[bvar1 X(:,dim+1:2*dim)];                   
%==========================================================================
%                        DISTRIBUTION LOAD FLOW
%==========================================================================
PL=zeros(Materials_no,1);
Vb=zeros(Materials_no,Nb);
for ii=1:Materials_no
    %======================================================================
    bvar4=zeros(Nb,1);
    %======================================================================
    ss3=bvar3(ii,1:dim);
    ss4=bvar3(ii,dim+1:2*dim);
    bvar4(ss3,1)=ss4;
    Qcc=bvar4;
    %======================================================================
    backward_forward_sweep               % Backward Forward Load Flow
    %======================================================================
    PL(ii,1)=PLoss;                % Power Losses for each solution (P.u.)
    Vb(ii,:)=V_bus;                % Voltage magnitude at each bus (P.u.)
    %======================================================================
end
PL;
%====================================================================
%                      FIRING CONSTRAINTS
%====================================================================
%constraints
%====================================================================
%                     Vmin = <  Vi  < =  Vmax
%====================================================================
const1=Vb;
for i=1:Materials_no;
    ppp1=find(const1(i,:)<0.95);%find the index of invisible solution
    ppp2=sum(ppp1);
    if ppp2>0
       PL(i,:)=inf;
    end
end
PL;
%====================================================================
%                         Nc < = Nc_max
%====================================================================
% const2=bvar2;
% for i=1:npop;
%     ppp3=find(const2(i,:)>1);  % find the index of invisible solution
%     ppp4=length(ppp3);
%     if ppp4>3
%        PL(i,:)=inf;
%     end
% end
% PL;
%====================================================================
%                      Qc_total < = 5000
%====================================================================
const3=bvar2;
for i=1:Materials_no;
    ppp5=find(const3(i,:)>1);  % find the index of invisible solution
    ppp6=const3(i,ppp5);
    ppp7=sum(ppp6);
    if ppp7>5000
       PL(i,:)=inf;
    end
end
PL;
%==========================================================================
%                     Initialize the population/solutions
%==========================================================================
Fitness=PL;
%==========================================================================
% Find the current best
sol1=[bvar1 bvar2 Fitness];
sol2=sortrows(sol1,2*dim+1);
bbst=[sol2(1,:)];
gbst=bbst(:,2*dim+1);
%==========================================================================
[Scorebest, Score_index] = min(Fitness);
Xbest=X(Score_index,:);
den_best=den(Score_index,:);
vol_best=vol(Score_index,:);
acc_best=acc(Score_index,:);
acc_norm=acc;
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
    acc=acc_norm;
    r=rand();
    %======================================================================
    for i=1:Materials_no
        den(i,:)=den(i,:)+r*(den_best-den(i,:));                  % Eq. (7)
        vol(i,:)=vol(i,:)+r*(vol_best-vol(i,:));
        if TF<.45                                                %collision
            mr=randi(Materials_no);
            acc_temp(i,:)=((den(mr,:).*vol(mr,:).*acc(mr,:)))./(den(i,:).*vol(i,:))*rand;   % Eq. (10)
        else
            acc_temp(i,:)=(den_best.*vol_best.*acc_best)./(den(i,:).*vol(i,:))*rand;        % Eq. (11)
        end
    end
    acc_norm=((u*(acc_temp-min(acc_temp(:))))./(max(acc_temp(:))-min(acc_temp(:))))+l;      % Eq. (12)
    %======================================================================
     for i=1:Materials_no
            if TF<.4
                for j=1:size(X,2)
                    mrand=randi(Materials_no);
                    Xnew(i,j)=X(i,j)+C1*rand*acc_norm(i,j).*(X(mrand,j)-X(i,j))*d;          % Eq. (13)
                end
            else
                for j=1:size(X,2)
                    p=2*rand-C4;                                                            % Eq. (15)
                    T=C3*TF;
                    if T>1
                        T=1;
                    end
                    if p<.5
                        Xnew(i,j)=Xbest(j)+C2*rand*acc_norm(i,j).*(T*Xbest(j)-X(i,j))*d;     % Eq. (14)
                    else
                        Xnew(i,j)=Xbest(j)-C2*rand*acc_norm(i,j).*(T*Xbest(j)-X(i,j))*d;
                    end
                end
            end
     end   
    %======================================================================
    %                         Objective Function
    %======================================================================
    bvar1=round(Xnew(:,1:dim));         % Capacitor Locations (0 off, 1 on)
    bvar2=Xnew(:,dim+1:2*dim);                       % Capacitor Sizing (KVAR)
    bvar3=[bvar1 X(:,dim+1:2*dim)];                   
    %======================================================================
    %                        DISTRIBUTION LOAD FLOW
    %======================================================================
    PL=zeros(Materials_no,1);
    Vb=zeros(Materials_no,Nb);
    for ii=1:Materials_no
        %==================================================================
        bvar4=zeros(Nb,1);
        %==================================================================
        ss3=bvar3(ii,1:dim);
        ss4=find(ss3(1,:)>Nb);
        ss3(1,ss4)=Nb;
        ss5=find(ss3(1,:)<2);
        ss3(1,ss5)=2;
        ss5=bvar3(ii,dim+1:2*dim);
        bvar4(ss3,1)=ss5;
        Qcc=bvar4;
        %==================================================================
        backward_forward_sweep               % Backward Forward Load Flow
        %==================================================================
        PL(ii,1)=PLoss;             % Power Losses for each solution (P.u.)
        Vb(ii,:)=V_bus;              % Voltage magnitude at each bus (P.u.)
        %==================================================================
    end
    PL;
    %====================================================================
    %                      FIRING CONSTRAINTS
    %====================================================================
    %constraints
    %====================================================================
    %                     Vmin = <  Vi  < =  Vmax
    %====================================================================
    const1=Vb;
    for i=1:Materials_no;
        ppp1=find(const1(i,:)<0.95);%find the index of invisible solution
        ppp2=sum(ppp1);
        if ppp2>0
           PL(i,:)=inf;
        end
    end
    PL;
    %====================================================================
    %                         Nc < = Nc_max
    %====================================================================
    % const2=bvar2;
    % for i=1:npop;
    %     ppp3=find(const2(i,:)>1);  % find the index of invisible solution
    %     ppp4=length(ppp3);
    %     if ppp4>3
    %        PL(i,:)=inf;
    %     end
    % end
    % PL;
    %====================================================================
    %                      Qc_total < = 5000
    %====================================================================
    const3=bvar2;
    for i=1:Materials_no;
        ppp5=find(const3(i,:)>1);  % find the index of invisible solution
        ppp6=const3(i,ppp5);
        ppp7=sum(ppp6);
        if ppp7>5000
           PL(i,:)=inf;
        end
    end
    PL;
    %======================================================================
    %                     Initialize the population/solutions
    %======================================================================
    Fitness=PL;
    %======================================================================
    % Find the current best
    sol1=[bvar1 bvar2 Fitness];
    sol2=sortrows(sol1,2*dim+1);
    bbst=[sol2(1,:)];
    gbst=bbst(:,2*dim+1);
    %======================================================================
    [gmin,ind]=min(bbst(:,2*dim+1));
    if gmin<gbst                                   
       gbst=gmin;
    end  
    %======================================================================
    ansr(t,:)=[bbst gbst];
    outt(t,:)=[t gmin gbst];
    eval(t)=gbst;
    %======================================================================
end
ansr;
%==========================================================================
fprintf('=================================================================')
sss1=sort(outt(:,3));
sss2=zeros(Max_iter,1);
sss3=[Max_iter:-1:1];
sss2(sss3,1)=sss1;
Fitness=sss2;
%==========================================================================
pp1=ansr(Max_iter,2*dim+2);
pp2=find(ansr(:,2*dim+2)==pp1);
pp3=ansr(pp2(1,1),1:2*dim)';
%==========================================================================
fprintf('=================================================================')
Qcc_Locations=pp3(1:dim,1);
Qcc_Size=pp3(dim+1:2*dim,1);
%==========================================================================
Qcc_Locations_Size_Kvar=[Qcc_Locations Qcc_Size]
% BF_C(Qcc_Locations,Qcc_Size)

Qcc_Total_Kvar=sum(Qcc_Locations_Size_Kvar(:,2))
%==========================================================================
bvar1=zeros(Nb,1);
%==========================================================================
ss1=Qcc_Locations;
ss2=Qcc_Size;
bvar1(ss1,1)=ss2;
Qcc1_Size_Kvar=bvar1;
%==========================================================================
backward_forward_sweep_final                   % Backward Forward Load Flow     
%==========================================================================
fprintf('=================================================================')
V_bus_with_C=V_bus;                    %Voltage magnitude at each bus (P.u.)
fprintf('=================================================================')
V_bus_tot_with_C=sum(V_bus_with_C)
%==========================================================================
%                        Voltage magnitude without Capacitors
%==========================================================================
fprintf('=================================================================')
V_bus_without_C=[ 1.0000
    0.9854
    0.9806
    0.9796
    0.9771
    0.9753
    0.9739
    0.9735
    0.9722
    0.9718
    0.9717
    0.9715
    0.9715
    0.9765
    0.9678
    0.9650
    0.9641
    0.9573
    0.9566
    0.9553
    0.9536
    0.9520
    0.9508
    0.9496
    0.9469
    0.9467
    0.9465
    0.9465
    0.9462
    0.9462];
fprintf('=================================================================')
V_bus_tot_without_C=sum(V_bus_without_C)
%==========================================================================
figure(1)
plot(outt(:,1),Fitness);
xlabel('Iteration');
ylabel('Total Power loss');
title('Convergence curve');
temp1='convergence curve';
saveas(gca,temp1);
%==========================================================================
figure(2)
plot(1:Nb,V_bus_without_C,'r',1:Nb,V_bus_with_C,'b')
xlabel('Buses');
ylabel('Bus Voltages (p.u.)');  
title(' Bus voltages vs Buses');
temp2='Bus voltages';
saveas(gca,temp2);
%==========================================================================
%                           Power Loss in each branch
%==========================================================================
fprintf('===============Active power loss in each branch (kW)=============')
Plosskw = (Pl) * 100000;
fprintf('=============Reactive power loss in each branch (kVAR)===========')
Qlosskw = (Ql) * 100000;
%==========================================================================
%                              Total Power Loss
%==========================================================================
fprintf('=================Total active power loss (kW)===================')
Total_PLoss = (PLL) * 100000
fprintf('===============Total reactive power loss (kVAR)=================')
Total_QLoss = (QLL) * 100000
%==========================================================================
fprintf('=================minimum voltage===================')
minimum_voltage = min(V_bus)
maximum_voltage =max(V_bus)
fprintf('case 2 voltages')
V_bus
over_all_power_factor=cos(atan(sum(BD(:,3))/sum(BD(:,2))))