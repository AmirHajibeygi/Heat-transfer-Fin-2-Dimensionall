clc
clear
disp("***********In the name of God***********")
disp("Wellcome to forth part of this project")
%central points in this shape are points that are in (60,j)
t=95;%c
q=5*10^4;%w/m^2
T_final=48;%c
D_x=0.001;%m
rho=7850;%kg/m^3
k_st=44.5;%w/m.k
k_cu=386;
cp=475;%j/kg.k
D_v=0.001^2;% m^3(for inner points)
Ci=rho*cp*D_v;%(for inner points)
Ci_border=0.5*Ci;%%(for points in borders)
Ci_corner=0.25*Ci;%%(for points in corner)
%%Now we should calculate R of whol points that exist on this shape
R_interior=D_x/(k_cu*(D_x)^2);
alpha=0.859*10^(-5);
T=ones(120,300)*40;
T_new=zeros(120,300);
T_need=ones(20,300);
n=1;
a=1;
f=1;
for i=1:120
    for j=1:300
        for t=0:5:95
            if i==1 && 1<j && j<300
                T_new(i,j)=t/Ci*(0.05+2*(0.5*(T(i+1,j)-T(i,j))/R_interior)+(T(i,j-1)-T(i,j))/R_interior+(T(i,j+1)-T(i,j))/R_interior)+T(i,j);
            end
            if i==120 && 1<j && j<300
                T_new(i,j)=t/Ci*(0.05+2*(0.5*(T(i-1,j)-T(i,j))/R_interior)+(T(i,j-1)-T(i,j))/R_interior+(T(i,j+1)-T(i,j))/R_interior)+T(i,j);
            end
            if j==1 && 1<i && i<120
                T_new(i,j)=t/Ci*(0.05+2*((T(i-1,j)-T(i,j))/R_interior)+0.5*((T(i,j+1)-T(i,j))/R_interior)+(T(i+1,j)-T(i,j))/R_interior)+T(i,j);
            end
            if j==300 && 1<i && i<120
                T_new(i,j)=t/Ci*(00.05+2*((T(i-1,j)-T(i,j))/R_interior)+0.5*((T(i,j-1)-T(i,j))/R_interior)+(T(i+1,j)-T(i,j))/R_interior)+T(i,j);
            end
            if i==1 && j==1
                T_new(i,j)=t/Ci*(0.05+((T(i+1,j)-T(i,j))/R_interior)+((T(i,j+1)-T(i,j))/R_interior))+T(i,j);
            end
            if i==120 && j==1
                T_new(i,j)=t/Ci*(0.05+((T(i-1,j)-T(i,j))/R_interior)+((T(i,j+1)-T(i,j))/R_interior))+T(i,j);
            end
            if i==120 && j==300
                T_new(i,j)=t/Ci*(0.05+((T(i-1,j)-T(i,j))/R_interior)+((T(i,j-1)-T(i,j))/R_interior))+T(i,j);
            end
            if i==1 && j==300
                 T_new(i,j)=t/Ci*(0.05+((T(i+1,j)-T(i,j))/R_interior)+((T(i,j-1)-T(i,j))/R_interior))+T(i,j);
            end
            if 1<i && i<120 && 1<j && j<300
                T_new(i,j)=t/Ci*(0.05+(T(i-1,j)-T(i,j))/R_interior+(T(i,j-1)-T(i,j))/R_interior+(T(i+1,j)-T(i,j))/R_interior+(T(i,j+1)-T(i,j))/R_interior)+T(i,j);
            end
            
        end
        if j<300 && j>1 && i==60
                    T_need(n,j)=T(i,j);
                    n=n+1;
        end
            if n>20
                 break
            end
            T=T_new;
        if n>20
                break
        end
    end
end
[X,time_t]=meshgrid(0:0.1:29.9,0:5:95);
surf(time_t,X,T_need)
colorbar
size(T_need)
size(X)
size(time_t)