function [Vm,Tm] = X_MTK5( Pc0,Uc,Sigmac,Pe0,Ue,Sigmae,Zeta0,Uz,Sigmaz,q,IC,Eta,Delta,Theta,Rv,Ri1,Ri2,Ri3,r,T,m,n,Pp0,Ge0,fr,Tr )


dt = T/n;


Pc=zeros(m,n+1+Tr);
Pe=zeros(m,n+1+Tr);
Zeta=zeros(m,n+1+Tr);
CumPi=zeros(m,n);
MTn1=randn(m,n+Tr);
MTn2=randn(m,n+Tr);
MTn3=randn(m,n+Tr);
Pc(:,1)=Pc0;
Pe(:,1)=Pe0;
Zeta(:,1)=Zeta0;
ER=zeros(m,n+Tr);
CR=zeros(m,n+Tr);
OM=Theta*q*IC*(1-Eta);
Tax=zeros(m,n+Tr);
Pi=zeros(m,n+Tr);
I=zeros(m,n);
Fn=zeros(m,n);
EFn=zeros(m,n);
Vn=zeros(m,n);
Tn=zeros(m,1);
Gn=zeros(m,1);
Xn=zeros(m,2);
Pp=zeros(m,n+1+Tr);
Pp(:,1)=Pp0;



for i=1:m
    for j=1:n+Tr
        Pc(i,j+1)=Pc(i,j)*exp((Uc-Sigmac/2)*dt+Sigmac*sqrt(dt)*MTn1(i,j));
     
        Pe(i,j+1)=Pe(i,j)*exp((Ue-Sigmae/2)*dt+Sigmae*sqrt(dt)*MTn2(i,j));
    
        Zeta(i,j+1)=Zeta(i,j)*exp((Uz-Sigmaz/2)*dt+Sigmaz*sqrt(dt)*MTn3(i,j));
   
        Pp(i,j+1)=Pp(i,j)*(1+Uz)^(j-1);
        ER(i,j)=(Pe(i,j)+Pp(i,j))*q*IC*(1-Eta);
        CR(i,j)=Pc(i,j)*q*IC*(1-Eta);
   
        Pi(i,j)=ER(i,j)+CR(i,j)-OM;
       
        I(i,j)=Zeta(i,j)*IC;
 
    end
end

for i=1:m
    for j=1:n
      for k=j:j+Tr
          s=1;
        if s<=3
        Tax(i,k)=(ER(i,k)+CR(i,k))*Rv+max((ER(i,k)+CR(i,k))*(1-Rv)-OM,0)*Ri1;
        
        else if s<=6
        Tax(i,k)=(ER(i,k)+CR(i,k))*Rv+max((ER(i,k)+CR(i,k))*(1-Rv)-OM,0)*Ri2;
       
            else
                Tax(i,k)=(ER(i,k)+CR(i,k))*Rv+max((ER(i,k)+CR(i,k))*(1-Rv)-OM,0)*Ri3;
               
            end
        end
        CumPi(i,j)=CumPi(i,j)+(Pi(i,k)-Tax(i,k))*exp((j-k)*r*dt);
       
        s=s+1;
      end
        Vn(i,j)=CumPi(i,j)-I(i,j);
        
    end
end

Fn(:,n)=max(Vn(:,n),0);


for j=1:n-1
    k=n-j;
    Xn=[CumPi(:,k),I(:,k)];
   
    P0=[1 1 1 1 1];
    P=lsqcurvefit(@myfun,P0,Xn,Fn(:,k+1)*exp(-r*dt));
    for l=1:10
    P=lsqcurvefit(@myfun,P,Xn,Fn(:,k+1)*exp(-r*dt));
    end
   
    for i=1:m
    EFn(i,k+1)=(P(1)+P(2)*CumPi(i,k)+P(3)*CumPi(i,k).^2+P(4)*I(i,k)+P(5)*I(i,k).^2)*exp(r*dt);
    
    Fn(i,k)=max(Vn(i,k),EFn(i,k+1)*exp(-r*dt));
    end
end

for i=1:m
    for j=1:n
        if  Fn(i,j)==Vn(i,j)        
            break
        end
    end
    Tn(i)=j;
    Gn(i)=Fn(i,j)*exp(-r*j*dt);
end


Ta=unique(Tn);
Tb=histc(Tn,Ta);
Tm=mode(Tn);


Vm=sum(Gn)/m;
end