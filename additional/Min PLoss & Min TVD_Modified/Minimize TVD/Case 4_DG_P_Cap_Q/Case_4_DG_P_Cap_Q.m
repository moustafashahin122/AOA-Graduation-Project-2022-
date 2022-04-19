clc;
clear all;
format long
%==========================================================================
% rand('seed',0)
%==========================================================================
%                 Archimedes optimization algorithm (AOA)
%==========================================================================
tic
%==========================================================================
Nb=34;                                                       % No. of buses
%==========================================================================
Materials_no=50;                                      % Number of Particles                               
dim=3;                                        % Number of control varaibles
Max_iter=10;                                % Maximum number of iterations
%==========================================================================
% C3=2;C4=.5;                                 %cec and engineering problems
C3=1;C4=2;                                 %standard Optimization functions
%==========================================================================
PDG_min=500;                                         % Minimum limit of DGs
PDG_max=1500;                                        % Maximum limit of DGs
%==========================================================================
Qc_min=500;                                    % Minimum limit of capacitor
Qc_max=1200;                                   % Maximum limit of capacitor
%==========================================================================
bounds=[2 34;2 34;2 34;2 34;2 34;2 34];
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
    for j=1:nv;
        x1(k,j)=L(j)+rand*rang(j);            
    end
end 
x1;                                       % Locations of DGs and Capacitors
%==========================================================================
bounds1=[PDG_min PDG_max;PDG_min PDG_max;PDG_min PDG_max];
%==========================================================================
nv1=size(bounds1,1);                                       % No. of variables
L1=bounds1(:,1)';                                          % Lower boundaries
Lmax1=L1([ones(Materials_no,1)],1:nv1);
H1=bounds1(:,2)';                                          % Upper boundaries
Hmax1=H1([ones(Materials_no,1)],1:nv1);
rang1=H1-L1;
%==========================================================================
% Initial population
%==========================================================================
for k=1:Materials_no;
    for j=1:dim;
        x2(k,j)=L1(j)+rand*rang1(j);            
    end
end 
x2;                                                         % Sizing of DGs
%==========================================================================
bounds2=[Qc_min Qc_max;Qc_min Qc_max;Qc_min Qc_max];
%==========================================================================
nv2=size(bounds2,1);                                       % No. of variables
L2=bounds2(:,1)';                                          % Lower boundaries
Lmax2=L2([ones(Materials_no,1)],1:nv2);
H2=bounds2(:,2)';                                          % Upper boundaries
Hmax2=H2([ones(Materials_no,1)],1:nv2);
rang2=H2-L2;
%==========================================================================
% Initial population
%==========================================================================
for k=1:Materials_no;
    for j=1:nv2;
        x3(k,j)=L2(j)+rand*rang2(j);            
    end
end 
x3;                                                 % Sitting of Capacitors
%==========================================================================
%                              Initialization
%==========================================================================
C1=0.5;
C2=0.5;
%==========================================================================
u=.9;                                                 %paramter in Eq. (12)
l=.1;                                                 %paramter in Eq. (12)
X=[x1 x2 x3];                                       %initial positions Eq. (4)
den=rand(Materials_no,4*dim);                                       % Eq. (5)
vol=rand(Materials_no,4*dim);
ss1=ones(Materials_no,2*dim)+rand(Materials_no,2*dim)*(Nb-2);
ss2=PDG_min*ones(Materials_no,dim)+rand(Materials_no,dim)*(PDG_max-PDG_min);
ss3=Qc_min*ones(Materials_no,dim)+rand(Materials_no,dim)*(Qc_max-Qc_min);
acc=[ss1 ss2 ss2];                                                 % Eq. (6)
%==========================================================================
%                         Objective Function
%==========================================================================
bvar1=round(X(:,1:nv));                % Capacitor Locations (0 off, 1 on)
bvar2=X(:,nv+1:nv+dim);                                    % DG Sizing (kW)
bvar3=X(:,nv+dim+1:2*nv);                          % Capacitor Sizing (kVAR)                  
%==========================================================================
%                        DISTRIBUTION LOAD FLOW
%==========================================================================
PL=zeros(Materials_no,1);
Vb=zeros(Materials_no,Nb);
TVD=zeros(Materials_no,1);
for ii=1:Materials_no
    %======================================================================
    bvar4=zeros(Nb,1);
    bvar5=zeros(Nb,1);
    bvar6=bvar1(ii,1:nv/2);
    bvar4(bvar6,:)=bvar2(ii,:);
    P_dg=bvar4;
    %===============================
    bvar7=bvar1(ii,1+nv/2:nv);
    bvar5(bvar7,:)=bvar3(ii,:);
    Q_cc=bvar5;
    %======================================================================
    backward_forward_sweep               % Backward Forward Load Flow
    %======================================================================
    PL(ii,1)=PLoss;                % Power Losses for each solution (P.u.)
    Vb(ii,:)=V_bus;                % Voltage magnitude at each bus (P.u.)
        %======================================================================
    mm1=ones(Nb,1);
    mm2=(Vb(ii,:))';
    TVD(ii,1)=sum((mm1-mm2).^2);
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
       TVD(i,:)=inf;
    end
end
TVD;
%====================================================================
%                         Nc < = Nc_max
%====================================================================
const2=Vb;
for i=1:Materials_no;
    ppp3=find(const2(i,:)>1);  % find the index of invisible solution
    ppp4=length(ppp3);
    if ppp4>3
       TVD(i,:)=inf;
    end
end
TVD;
%====================================================================
%                      QDG < = 3007
%====================================================================
const3=bvar2;
for i=1:Materials_no;
    ppp5=find(const3(i,:)>1);  % find the index of invisible solution
    ppp6=const3(i,ppp5);
    ppp7=sum(ppp6);
    if ppp7>3000
       TVD(i,:)=inf;
    end
end
TVD;
%====================================================================
%                      Qcc < = 3007
%====================================================================
const4=bvar3;
for i=1:Materials_no;
    ppp8=find(const4(i,:)>1);  % find the index of invisible solution
    ppp9=const3(i,ppp8);
    ppp10=sum(ppp9);
    if ppp10>3007
       TVD(i,:)=inf;
    end
end
TVD;
%==========================================================================
%                     Initialize the population/solutions
%==========================================================================
Fitness=TVD;
%==========================================================================
% Find the current best
sol1=[bvar1 bvar2 bvar3 Fitness];
sol2=sortrows(sol1,2*nv+1);
bbst=[sol2(1,:)];
gbst=bbst(:,2*nv+1);
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
    bvar1=round(Xnew(:,1:nv));    % DGs and Capacitors Locations (0 off, 1 on)
    bvar2=Xnew(:,nv+1:nv+dim);                                % DG Sizing (kW)
    bvar3=Xnew(:,nv+dim+1:2*nv);                     % Capacitor Sizing (kVAR)                        
    %======================================================================
    %                        DISTRIBUTION LOAD FLOW
    %======================================================================
    PL=zeros(Materials_no,1);
    Vb=zeros(Materials_no,Nb);
    TVD=zeros(Materials_no,1);
    for ii=1:Materials_no
        %==================================================================
        bvar4=zeros(Nb,1);
        bvar5=zeros(Nb,1);
        bvar6=bvar1(ii,1:nv/2);
        sss1=find(bvar6(1,:)<2);
        bvar6(1,sss1)=2;
        bvar4(bvar6,:)=bvar2(ii,:);
        P_dg=bvar4;
        %===============================
         bvar7=bvar1(ii,1+nv/2:nv);
         sss2=find(bvar7(1,:)<2);
         bvar7(1,sss2)=2;
         bvar5(bvar7,:)=bvar3(ii,:);
         Q_cc=bvar5;
         %======================================================================
         backward_forward_sweep               % Backward Forward Load Flow
         %======================================================================
         PL(ii,1)=PLoss;                % Power Losses for each solution (P.u.)
         Vb(ii,:)=V_bus;                % Voltage magnitude at each bus (P.u.)
                %======================================================================
        mm1=ones(Nb,1);
        mm2=(Vb(ii,:))';
        TVD(ii,1)=sum((mm1-mm2).^2);
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
           TVD(i,:)=inf;
        end
    end
    TVD;
    %====================================================================
    %                         Nc < = Nc_max
    %====================================================================
    const2=Vb;
    for i=1:Materials_no;
        ppp3=find(const2(i,:)>1);  % find the index of invisible solution
        ppp4=length(ppp3);
        if ppp4>3
           TVD(i,:)=inf;
        end
    end
    TVD;
    %====================================================================
    %                      PDG_total < = 3000
    %====================================================================
    const3=bvar2;
    for i=1:Materials_no;
        ppp5=find(const3(i,:)>1);  % find the index of invisible solution
        ppp6=const3(i,ppp5);
        ppp7=sum(ppp6);
        if ppp7>3000
           TVD(i,:)=inf;
        end
    end
    TVD;
    %====================================================================
    %                      Qcc < = 3007
    %====================================================================
    const4=bvar3;
    for i=1:Materials_no;
        ppp8=find(const4(i,:)>1);  % find the index of invisible solution
        ppp9=const3(i,ppp8);
        ppp10=sum(ppp9);
        if ppp10>3007
           TVD(i,:)=inf;
        end
    end
    TVD;
    %======================================================================
    %                     Initialize the population/solutions
    %======================================================================
    Fitness=TVD;
    %======================================================================
    % Find the current best
    sol1=[bvar1 bvar2 bvar3 Fitness];
    sol2=sortrows(sol1,2*nv+1);
    bbst=[sol2(1,:)];
    gbst=bbst(:,2*nv+1);
    %======================================================================
    [gmin,ind]=min(bbst(:,2*nv+1));
    if gmin<gbst                                   
       gbst=gmin;
    end  
    %======================================================================
    ansr(t,:)=[bbst gbst];
    outt(t,:)=[t gmin gbst];
    eval(t)=gbst;
    %======================================================================
end
ansr
%==========================================================================
fprintf('=================================================================')
outt1=outt(:,3);
outt2=sortrows(outt1);
ss1=[1:1:Max_iter];
ss2=[Max_iter:-1:1];
ss3=zeros(Max_iter,1);
ss3(ss1,:)=outt2(ss2,:);
TVD_Converg=ss3
%==========================================================================
pp1=min(ansr(:,2*nv+2));
pp2=find(ansr(:,2*nv+1)==pp1);
pp3=ansr(pp2(1,1),1:2*nv);
%==========================================================================
pp4=pp3(:,1:nv);
pp5=pp3(:,nv+1:nv+nv1);
pp6=pp3(:,nv+nv1+1:2*nv);
% pp7=find(pp5(:,1:N_RES)>0);
%==========================================================================
fprintf('=================================================================')
F1=ansr(pp2(1,1),2*nv+2)
% fprintf('============================')
% F2=ansr(pp2(1,1),nv+2)
% fprintf('============================')
% F3=ansr(pp2(1,1),nv+3)
%==========================================================================
fprintf('=================================================================')
Locations_DG=pp4(:,1:nv1)
fprintf('============================')
Number_of_DGs=length(Locations_DG)
Pdg_Size=pp5;
%==========================================================================
fprintf('=================================================================')
Pdg_Locations_Size_Kw=[Locations_DG' Pdg_Size']
Pdg_Total_Kw=sum(Pdg_Locations_Size_Kw(:,2))
%==========================================================================
fprintf('=================================================================')
Locations_Cap=pp4(:,nv1+1:nv)
fprintf('============================')
Number_of_Cap=length(Locations_Cap)
Qcc_Size=pp6;
%==========================================================================
fprintf('=================================================================')
Qcc_Locations_Size_KVAR=[Locations_Cap' Qcc_Size']
Qcc_Total_KVAR=sum(Qcc_Locations_Size_KVAR(:,2))
%==========================================================================
bvar1=zeros(1,Nb);
bvar2=zeros(1,Nb);
bvar1(:,Locations_DG)=pp5;
bvar2(:,Locations_Cap)=pp6;
bvar3=bvar1';
bvar4=bvar2';
%==========================================================================
backward_forward_sweep_final                   % Backward Forward Load Flow     
%==========================================================================
fprintf('=================================================================')
V_bus_with_DG_C=V_bus                    %Voltage magnitude at each bus (P.u.)
fprintf('=================================================================')
V_bus_tot_with_DG_C=sum(V_bus_with_DG_C)
%==========================================================================
fprintf('=================================================================')
ss4=[1:Nb]';;
ss5=[ss4 V_bus];
ss6=sortrows(ss5,2);
Min_Voltage=ss6(1,:)
fprintf('=============================')
Max_Voltage=ss6(Nb-1,:)
%==========================================================================
%                    Voltage magnitude without DG & Capacitors
%==========================================================================
V_bus_without_DG_C=[1.0000
    0.9941
    0.9890
    0.9820
    0.9761
    0.9704
    0.9666
    0.9645
    0.9620
    0.9608
    0.9604
    0.9602
    0.9887
    0.9884
    0.9883
    0.9883
    0.9659
    0.9622
    0.9581
    0.9548
    0.9520
    0.9487
    0.9460
    0.9435
    0.9423
    0.9418
    0.9417
    0.9662
    0.9660
    0.9659
    0.9605
    0.9601
    0.9600
    0.9599];
%==========================================================================
figure(1)
plot(outt(:,1),TVD_Converg);
xlabel('Iteration');
ylabel('Total Power loss (KW)');
title('Convergence curve');
%==========================================================================
figure(2)
plot(1:Nb,V_bus_without_DG_C,'r',1:Nb,V_bus_with_DG_C,'b')
xlabel('Buses');
ylabel('Bus Voltages (p.u.)');  
title(' Bus voltages vs Bus Number')  
% %==========================================================================
% %                           Power Loss in each branch
% %==========================================================================
% fprintf('===============Active power loss in each branch (kW)=============')
% Plosskw = (Pl) * 100000;
% fprintf('=============Reactive power loss in each branch (kVAR)===========')
% Qlosskw = (Ql) * 100000;
% %==========================================================================
% %                              Total Power Loss
% %==========================================================================
% fprintf('=================Total active power loss (kW)===================')
% Total_PLoss = (PLL) * 100000
% fprintf('===============Total reactive power loss (kVAR)=================')
% Total_QLoss = (QLL) * 100000
% %==========================================================================
% fprintf('=================minimum voltage===================')
% minimum_voltage = min(V_bus)
% maximum_voltage =max(V_bus)
% fprintf('case 4 voltages')
% Voltages_case_4=V_bus
% over_all_power_factor=cos(atan(sum(BD(:,3))/sum(BD(:,2))))