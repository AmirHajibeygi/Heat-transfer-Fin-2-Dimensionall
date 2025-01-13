clc
clear
disp("**********In the name of God***********")
disp("Wellcome to third part of this project")
t=95;%c
q=5*10^4;%w/m^2
T_final=48;%c
D_x=0.001;%m
rho=7850;%kg/m^3
k_st=44.5;%w/m.k
cp=475;%j/kg.k
D_v=0.001^2;% m^3(for inner points)
Ci=rho*cp*D_v;%(for inner points)
Ci_border=0.5*Ci;%%(for points in borders)
Ci_corner=0.25*Ci;%%(for points in corner)
%%Now we should calculate R of whol points that exist on this shape
R_interior=D_x/(k_st*(D_x)^2);
alpha=0.859*10^(-5);
T=ones(120,300)*40;
T_new=zeros(120,300);
T_need=ones(1,20);
%We calculated conditions in borders and interior points and ... 
for i=1:120
    for j=1:300
        if 1<i && i<120 && 1<j && j<300
            T_new(i,j)=t/Ci*(0.05+(T(i-1,j)-T(i,j))/R_interior+(T(i,j-1)-T(i,j))/R_interior+(T(i+1,j)-T(i,j))/R_interior+(T(i,j+1)-T(i,j))/R_interior)+T(i,j);
        end
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
        T=T_new;
    end
end
%Now we can calculate maximum temperature...
T_max=max(max(T));
disp(T_max)
[row,column]= find(T==T_max);
%We find the location of T_max so we will check the amount of this arrey in
%every times
n=1;
for i=1:120
    for j=1:300
        for t=0:5:95
            if 1<i && i<120 && 1<j && j<300
                T_new(i,j)=t/Ci*(0.05+(T(i-1,j)-T(i,j))/R_interior+(T(i,j-1)-T(i,j))/R_interior+(T(i+1,j)-T(i,j))/R_interior+(T(i,j+1)-T(i,j))/R_interior)+T(i,j);
            end
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
                T_need(1,n)=T_new(i,j);
                n=n+1;
            end
            if i==1 && j==300
                 T_new(i,j)=t/Ci*(0.05+((T(i+1,j)-T(i,j))/R_interior)+((T(i,j-1)-T(i,j))/R_interior))+T(i,j);
            end
            T=T_new;
        end
    end
end
time=[0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95];
plot(time,T_need)
