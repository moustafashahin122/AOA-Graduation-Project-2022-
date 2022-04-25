clear all
clc

Networks;


%==========================================================================
%case 1 DGs at unity power factor
%==========================================================================

% caps_locations =
% 
%      []
% 
% 
% caps_sizes =
% 
%      []
% 
% 
% caps_tot_size =
% 
%      0
% 
% 
% DGs_locations =
% 
%     26    32
% 
% 
% DGs_sizes =
% 
%    1.0e+03 *
% 
%     1.9514    1.5486
% 
% 
% kvar =
% 
%      0     0
% 
% 
% DGs_tot_size =
% 
%    3.5000e+03
% 
% 
% V_min =
% 
%     0.9883
% 
% 
% V_max =
% 
%      1
% 
% 
% Total_PLoss =
% 
%    82.9864
% 
% 
% Total_QLoss =
% 
%    22.0078
% 
% 
% TVD =
% 
%     0.0017
% 
% 
% over_all_power_factor =
% 
%     0.3678
% 
% 
% min_conv =
% 
%     0.0017


case_1_conv =[

    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0030
    0.0024
    0.0022
    0.0021
    0.0020
    0.0020
    0.0019
    0.0019
    0.0019
    0.0019
    0.0018
    0.0018
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017
    0.0017];


case_1_v =[

    1.0000
    0.9977
    0.9958
    0.9938
    0.9923
    0.9912
    0.9915
    0.9922
    0.9938
    0.9954
    0.9949
    0.9948
    0.9955
    0.9952
    0.9951
    0.9951
    0.9898
    0.9889
    0.9883
    0.9883
    0.9886
    0.9897
    0.9914
    0.9941
    0.9963
    0.9980
    0.9979
    0.9912
    0.9910
    0.9909
    0.9970
    0.9994
    0.9992
    0.9992];

% 
% minee =
% 
%     0.9883
% 
% 
% minbus =
% 
%     20

%==========================================================================
%case 2 DGs at .9 power factor
%==========================================================================

% 
% caps_locations =
% 
%      []
% 
% 
% caps_sizes =
% 
%      []
% 
% 
% caps_tot_size =
% 
%      0
% 
% 
% DGs_locations =
% 
%     31    24
% 
% 
% DGs_sizes =
% 
%    1.0e+03 *
% 
%     1.5001    1.9999
% 
% 
% kvar =
% 
%   726.5142  968.6130
% 
% 
% DGs_tot_size =
% 
%    3.5000e+03
% 
% 
% V_min =
% 
%     0.9932
% 
% 
% V_max =
% 
%     1.0013
% 
% 
% Total_PLoss =
% 
%    24.3237
% 
% 
% Total_QLoss =
% 
%     5.7131
% 
% 
% TVD =
% 
%    4.9664e-04
% 
% 
% over_all_power_factor =
% 
%     0.6942
% 
% 
% min_conv =
% 
%    4.9664e-04
% 

case_2_conv =[

    0.0015
    0.0014
    0.0013
    0.0013
    0.0013
    0.0013
    0.0013
    0.0013
    0.0013
    0.0013
    0.0013
    0.0013
    0.0013
    0.0013
    0.0013
    0.0011
    0.0009
    0.0008
    0.0006
    0.0006
    0.0006
    0.0006
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005
    0.0005];


case_2_v =[

    1.0000
    0.9984
    0.9972
    0.9959
    0.9951
    0.9946
    0.9951
    0.9959
    0.9977
    0.9994
    0.9990
    0.9988
    0.9969
    0.9966
    0.9965
    0.9965
    0.9937
    0.9932
    0.9932
    0.9935
    0.9943
    0.9959
    0.9980
    1.0013
    1.0001
    0.9997
    0.9995
    0.9948
    0.9946
    0.9945
    1.0012
    1.0009
    1.0007
    1.0006];


% minee =
% 
%     0.9932
% 
% 
% minbus =
% 
%     19


%==========================================================================
%case 3 caps only
%==========================================================================
% caps_locations =
% 
%     11    10    26
% 
% 
% caps_sizes =
% 
%    1.0e+03 *
% 
%     1.2000    1.1999    1.2000
% 
% 
% caps_tot_size =
% 
%    3.5999e+03
% 
% 
% DGs_locations =
% 
%      []
% 
% 
% DGs_sizes =
% 
%      []
% 
% 
% kvar =
% 
%      []
% 
% 
% DGs_tot_size =
% 
%      0
% 
% 
% V_min =
% 
%     0.9532
% 
% 
% V_max =
% 
%      1
% 
% 
% Total_PLoss =
% 
%   202.6912
% 
% 
% Total_QLoss =
% 
%    55.1960
% 
% 
% TVD =
% 
%     0.0295
% 
% 
% over_all_power_factor =
% 
%     0.9879
% 
% 
% min_conv =
% 
%     0.0295


case_3_conv =[

    0.0337
    0.0333
    0.0316
    0.0316
    0.0316
    0.0316
    0.0316
    0.0316
    0.0316
    0.0316
    0.0316
    0.0316
    0.0316
    0.0316
    0.0316
    0.0312
    0.0309
    0.0303
    0.0302
    0.0299
    0.0299
    0.0299
    0.0298
    0.0298
    0.0298
    0.0297
    0.0297
    0.0297
    0.0297
    0.0296
    0.0296
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295
    0.0295];


case_3_v =[

    1.0000
    0.9956
    0.9918
    0.9862
    0.9815
    0.9772
    0.9744
    0.9730
    0.9716
    0.9712
    0.9709
    0.9708
    0.9915
    0.9912
    0.9911
    0.9911
    0.9733
    0.9700
    0.9665
    0.9637
    0.9613
    0.9585
    0.9563
    0.9544
    0.9535
    0.9533
    0.9532
    0.9741
    0.9738
    0.9737
    0.9708
    0.9705
    0.9703
    0.9703];


% minee =
% 
%     0.9532
% 
% 
% minbus =
% 
%     27

%==========================================================================
%case 4 DG unity and caps 
%==========================================================================
% caps_locations =
% 
%     19     6
% 
% 
% caps_sizes =
% 
%   821.6635  555.7210
% 
% 
% caps_tot_size =
% 
%    1.3774e+03
% 
% 
% DGs_locations =
% 
%     25    25    11
% 
% 
% DGs_sizes =
% 
%    1.0e+03 *
% 
%     0.8183    1.0439    1.6378
% 
% 
% kvar =
% 
%      0     0     0
% 
% 
% DGs_tot_size =
% 
%    3.5000e+03
% 
% 
% V_min =
% 
%     0.9914
% 
% 
% V_max =
% 
%     1.0002
% 
% 
% Total_PLoss =
% 
%    38.4743
% 
% 
% Total_QLoss =
% 
%     9.0293
% 
% 
% TVD =
% 
%    7.7835e-04
% 
% 
% over_all_power_factor =
% 
%     0.6049
% 
% 
% min_conv =
% 
%    7.7835e-04


case_4_conv =[

    0.0018
    0.0018
    0.0018
    0.0018
    0.0018
    0.0016
    0.0016
    0.0016
    0.0016
    0.0016
    0.0016
    0.0016
    0.0016
    0.0016
    0.0016
    0.0014
    0.0012
    0.0011
    0.0011
    0.0011
    0.0011
    0.0009
    0.0009
    0.0009
    0.0009
    0.0009
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008
    0.0008];


case_4_v =[

    1.0000
    0.9983
    0.9969
    0.9955
    0.9945
    0.9939
    0.9945
    0.9953
    0.9972
    0.9989
    1.0002
    1.0001
    0.9966
    0.9963
    0.9962
    0.9962
    0.9928
    0.9921
    0.9917
    0.9914
    0.9916
    0.9926
    0.9941
    0.9965
    0.9986
    0.9982
    0.9980
    0.9942
    0.9939
    0.9938
    0.9985
    0.9982
    0.9980
    0.9980];


% minee =
% 
%     0.9914
% 
% 
% minbus =
% 
%     20
%==========================================================================
%case 5 DG pf .9 and caps only
%==========================================================================

% 
% caps_locations =
% 
%     17
% 
% 
% caps_sizes =
% 
%    1.0594e+03
% 
% 
% caps_tot_size =
% 
%    1.0594e+03
% 
% 
% DGs_locations =
% 
%     10    20    25
% 
% 
% DGs_sizes =
% 
%    1.0e+03 *
% 
%     1.1664    0.9931    1.3405
% 
% 
% kvar =
% 
%   564.8893  480.9892  649.2350
% 
% 
% DGs_tot_size =
% 
%    3.5000e+03
% 
% 
% V_min =
% 
%     0.9955
% 
% 
% V_max =
% 
%     1.0013
% 
% 
% Total_PLoss =
% 
%     9.2909
% 
% 
% Total_QLoss =
% 
%     2.3618
% 
% 
% TVD =
% 
%    2.3238e-04
% 
% 
% over_all_power_factor =
% 
%     0.9946
% 
% 
% min_conv =
% 
%    2.3238e-04


case_5_conv =[

    0.0024
    0.0023
    0.0017
    0.0017
    0.0016
    0.0014
    0.0010
    0.0007
    0.0004
    0.0004
    0.0004
    0.0004
    0.0004
    0.0004
    0.0004
    0.0004
    0.0004
    0.0004
    0.0004
    0.0004
    0.0003
    0.0003
    0.0003
    0.0003
    0.0003
    0.0003
    0.0003
    0.0003
    0.0003
    0.0003
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002
    0.0002];


case_5_v =[

    1.0000
    0.9988
    0.9980
    0.9972
    0.9967
    0.9966
    0.9962
    0.9964
    0.9973
    0.9983
    0.9979
    0.9977
    0.9977
    0.9974
    0.9973
    0.9973
    0.9967
    0.9968
    0.9974
    0.9983
    0.9979
    0.9980
    0.9986
    1.0000
    1.0013
    1.0009
    1.0008
    0.9959
    0.9956
    0.9955
    0.9980
    0.9977
    0.9975
    0.9974];


% minee =
% 
%     0.9955
% 
% 
% minbus =
% 
%     30





%==========================================================================
%==========================================================================
%==========================================================================
%==========================================================================


case_0= IEEE_34.voltages









x=1:IEEE_34.Nb;
w=1:50;
for i=1:IEEE_34.Nb;
    y(i)=.95;
end


for i=1:34;
    y(i)=.95;
end
figure(1)
plot(x,case_0,'-or',x,case_1_v,'-b^',x,case_2_v,'-m^',x,case_3_v,'-^g',x,case_4_v,'-^',x,case_5_v,'-^',x,y,'k--')
legend('case 0','case 1','case 2','case 3','case 4','case 5','minimum voltage')
title('34 Bus')
xlabel('Bus')
ylabel('voltage P.U.')
temp1=['voltage profile','.png'];
saveas(gca,temp1);
figure(2)
plot(w,case_2_conv,'-m^',w,case_1_conv,'-^g',w,case_4_conv,'-^',w,case_5_conv,'-^')
legend('case 2','case 1','case 4','case 5')
title('convergence curve')
xlabel('Bus')
ylabel('TVD')
temp1=['convergence curve 4 cases','.png'];
saveas(gca,temp1);
figure(3)
plot(w,case_3_conv,'-b^')
legend('case 3')
title('convergence curve')
xlabel('Bus')
ylabel('TVD')
temp1=['convergence curve cap','.png'];
saveas(gca,temp1);