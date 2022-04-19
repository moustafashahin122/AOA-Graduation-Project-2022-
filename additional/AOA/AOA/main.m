clc;clear all;
close all
fobj = @sumsqu;nvar=30;
lb=-10;
ub=10;
Materials_no=30;
Max_iter=1000;
dim=10;
% C3=2;C4=.5;  %cec and engineering problems
C3=1;C4=2;  %standard Optimization functions
[Xbest, Scorebest,Convergence_curve]=AOA(Materials_no,Max_iter,fobj, dim,lb,ub,C3,C4);
figure,semilogy(Convergence_curve,'r')
xlim([0 1000]);