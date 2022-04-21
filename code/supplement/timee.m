clear all
clc
format long
elapsedTime =[]
inc =1
for i=1:200
tic
BF_C([],[])

elapsedTime(i) = toc
end
number_of_candidate_solutions= 33*32*31*(700^3)*inc
meann=mean(elapsedTime)
years_for_BF = meann/(60*60*24*30*360)
years_to_find_best_solution= number_of_candidate_solutions*years_for_BF
fprintf('years = %5.5f\n',years_to_find_best_solution)
close all

