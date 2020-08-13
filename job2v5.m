clc;clear;
tic;

%%%  Code for sensitivity analysis %%% 
%%% Must be used with X_MTK5 %%%

Vm=zeros(10,1);
Tm=zeros(10,1);
result=zeros(10,3);
%Mn=[100;500;900;1300;1700;2100;2500;2900;3300;3700;4100;4500;4900;5300;5700;6100;6500;6900;7300;7700;8100;8500;8900;9300;9700];

for i=1:10
    Sigmaz=0+0.01*(i-1);
[ Vm(i,1),Tm(i,1)] = X_MTK5( 0.18,0.02,0.03,0.3,0.02,0.02,7500,-0.06,Sigmaz,3000,1,0.035,0.65,0.2,0.065,0,0.125,0.25,0.05,15,10000,15,0.1,1,-0.06,25);
%function [ Price,Time ] = X_MTK( Pc0,Uc,Sigmac,Pe0,Ue,Sigmae,Zeta0,Uz,Sigmaz,q,IC,Eta,Delta,Theta,Rv,Ri,r,T,m,n )


result(i,2)=Vm(i,1);
result(i,3)=Tm(i,1);
result(i,1)=Sigmaz;
end

plot(result(:,1),result(:,2));
xlabel('');
ylabel('');
title('');


figure;

plot(result(:,1),result(:,3));
xlabel('');
ylabel('');
title('');

toc;