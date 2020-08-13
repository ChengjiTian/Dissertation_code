clc;clear;
tic;

%%% Code for illustrates the simulation pathes %%%

Pc0=0.18;
Uc=0.02;
Sigmac=0.03;
Pe0=0.3;
Ue=0.02;
Sigmae=0.02;
Zeta0=7500;
Uz=-0.06;
Sigmaz=0.05;
q=3000;
IC=1;
Eta=0.035;
Delta=0.65;
Theta=0.2;
Rv=0.065;
Ri1=0;
Ri2=0.125;
Ri3=0.25;
r=0.05;
T=15;
m=10000;
n=15;
Pp=0.15;
Ge0=1;
fr=-0.02;
Tr=25;


dt = T/n;

Pc=zeros(m,n+1);
Pe=zeros(m,n+1);
Zeta=zeros(m,n+1);
CumPi=zeros(m,n+1);
MTn1=randn(m,n);
MTn2=randn(m,n);
MTn3=randn(m,n);
Pc(:,1)=Pc0;
Pe(:,1)=Pe0;
Zeta(:,1)=Zeta0;


for i=1:m
    for j=1:n
        Pc(i,j+1)=Pc(i,j)*exp((Uc-Sigmac/2)*dt+Sigmac*sqrt(dt)*MTn1(i,j));
        Pe(i,j+1)=Pe(i,j)*exp((Ue-Sigmae/2)*dt+Sigmae*sqrt(dt)*MTn2(i,j));
        Zeta(i,j+1)=Zeta(i,j)*exp((Uz-Sigmaz/2)*dt+Sigmaz*sqrt(dt)*MTn3(i,j));
    end
end

Pcs=zeros(m,n+1);
Pes=zeros(m,n+1);
Zetas=zeros(m,n+1);
Pcc=0.18:0.0033:0.25;
Pec=0.3:0.006:0.59;
Zetac=7500:-360:1790;

for i=1:10000
    s=0;
    for j=1:16
    if Pc(i,j)>=Pcc(1,j)
        s=s+1;
    end
    end
    if s==16
        Pcs(i,:)=Pc(i,:);
    end
end
Pcs(all(Pcs==0,2),:)=[];

for i=1:10000
    s=0;
    for j=1:16
     if Pe(i,j)>=Pec(1,j)
        s=s+1;
     end
    end
    if s==16
        Pes(i,:)=Pe(i,:);
    end
end
Pes(all(Pes==0,2),:)=[];

for i=1:10000
    s=0;
    for j=1:16
    if Zeta(i,j)>=Zetac(1,j)
        s=s+1;
    end
    end
    if s==16
        Zetas(i,:)=Zeta(i,:);
    end
end
Zetas(all(Zetas==0,2),:)=[];


plot(Pcs(1:100,:)');
title('');
B={'2020','2022','2024','2026','2028','2030','2032','2034'};

set(gca,'XTickLabel',B);
xlim=get(gca,'xlim');
xlim(1)=1;
set(gca,'xlim',xlim);
figure;
plot(Pes(1:100,:)');
title('');
set(gca,'XTickLabel',B);
xlim=get(gca,'xlim');
xlim(1)=1;
set(gca,'xlim',xlim);
figure;
plot(Zetas(1:100,:)');
title('');
set(gca,'XTickLabel',B);
xlim=get(gca,'xlim');
xlim(1)=1;
set(gca,'xlim',xlim);

toc;