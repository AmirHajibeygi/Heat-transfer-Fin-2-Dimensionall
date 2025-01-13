clc
clear
disp("*************In the name of God************")
disp("Wellcome to second part of project")
q=5*10^4;%w/m^2
T_final=48;%c
D_x=0.001;%m
rho=7850;%kg/m^3
k_cu=386;%w/m.k
cp=475;%j/kg.k
k_st=44.5;%w/m.c
D_v=0.001^2;% m^3(for inner points)
Ci=rho*cp*D_v;%(for inner points)
Ci_border=0.5*Ci;%%(for points in borders)
Ci_corner=0.25*Ci;%%(for points in corner)
%%Now we should calculate R of whol points that exist on this shape
R_interior=D_x/(k_st*(D_x)^2);
R_interior2=D_x/(k_cu*(D_x)^2);
alpha=0.859*10^(-5);
T=ones(120,300)*40;
T_new=zeros(120,300);
%We calculated conditions in borders and interior points and ... and we
%reached to this results(t<5.236 t<8.1379  t<20.9477)
T_cu=ones(400,100);
T_new_cu=ones(400,100);
for i=1:400
    for j=1:100
        for t=0:5:95
            if i>1 && i<400 && j>1 && j<50
            T_new_cu(i,j)=(t/Ci)*(0.05+(T_cu(i,j)-T_cu(i,j+1)+T_cu(i,j)+T_cu(i,j-1)+T_cu(i,j)-T_cu(i-1,j)+T_cu(i,j)-T_cu(i+1,j))/R_interior2)+T_cu(i,j);
            end
            if i>1 && i<140 && j>50 && j<100
             T_new_cu(i,j)=(t/Ci)*(0.05+(T_cu(i,j)-T_cu(i,j+1)+T_cu(i,j)+T_cu(i,j-1)+T_cu(i,j)-T_cu(i-1,j)+T_cu(i,j)-T_cu(i+1,j))/R_interior2)+T_cu(i,j);  
            end
            if i>260 && i<400 && j>50 && j<100
             T_new_cu(i,j)=(t/Ci)*(0.05+(T_cu(i,j)-T_cu(i,j+1)+T_cu(i,j)+T_cu(i,j-1)+T_cu(i,j)-T_cu(i-1,j)+T_cu(i,j)-T_cu(i+1,j))/R_interior)+T_cu(i,j);  
            end
            if j==50 && i<260 && i>140
                T_new_cu(i,j)=(t/Ci)*(0.05+(-(T(i-140,j-48)+T_cu(i,j-1)+T_cu(i+1,j)+T_cu(i-1,j))+4*T_cu(i,j))/R_interior2)+T_cu(i,j);
            end
            if j==100 && i<140 && i>1
                T_new_cu(i,j)=(t/Ci)*((0.05+((T_cu(i,j)-T_cu(i,j-1))/R_interior2)+2*(T_cu(i,j)-T_cu(i-1,j))/R_interior2)+2*(T_cu(i,j)-T_cu(i+1,j))/R_interior2);
            end
            if j==100 && i<400 && i>260
                T_new_cu(i,j)=(t/Ci)*((0.05+((T_cu(i,j)-T_cu(i,j-1))/R_interior2)+2*(T_cu(i,j)-T_cu(i-1,j))/R_interior2)+2*(T_cu(i,j)-T_cu(i+1,j))/R_interior2);
            end
            if i==140 && j>50 && j<100
                T_new_cu(i,j)=(t/Ci)*((0.05+((T_cu(i,j)-T_cu(i-1,j))/R_interior2)+(T_cu(i,j)-T_cu(i,j-1))/R_interior2)+(T_cu(i,j)-T_cu(i,j+1))/R_interior2+(T_cu(i,j)-T(i-139,j-49))/R_interior2);
            end
            if i==260 && j>50 && j<100
                T_new_cu(i,j)=(t/Ci)*((0.05+((T_cu(i,j)-T_cu(i+1,j))/R_interior2)+(T_cu(i,j)-T_cu(i,j-1))/R_interior2)+(T_cu(i,j)-T_cu(i,j+1))/R_interior2+(T_cu(i,j)-T(i-141,j-50))/R_interior2);
            end
            if i==1 && j>1&& j<100
                T_new_cu(i,j)=(t/Ci)*((0.05+((T_cu(i,j)-T_cu(i+1,j))/R_interior2)+2*(T_cu(i,j)-T_cu(i,j-1))/R_interior2)+2*(T_cu(i,j)-T_cu(i,j+1))/R_interior2);
            end
            if i==400 && j>1 && j<100
                T_new_cu(i,j)=(t/Ci)*((0.05+((T_cu(i,j)-T_cu(i-1,j))/R_interior2)+2*(T_cu(i,j)-T_cu(i,j-1))/R_interior2)+2*(T_cu(i,j)-T_cu(i,j+1))/R_interior2);
            end
            if j==1 && i<400 && i>1
                T_new_cu(i,j)=(t/Ci)*((0.05+2*((T_cu(i,j)-T_cu(i-1,j))/R_interior2)+(T_cu(i,j)-T_cu(i,j+1))/R_interior2)+2*(T_cu(i,j)-T_cu(i+1,j))/R_interior2);
            end
        end
    end
end
for i=1:120
    for j=1:300
        for t=0:5:100
            if 1<i && i<120 && 1<j && j<300
                T_new(i,j)=t/Ci*(0.05+(T(i-1,j)-T(i,j))/R_interior+(T(i,j-1)-T(i,j))/R_interior+(T(i+1,j)-T(i,j))/R_interior+(T(i,j+1)-T(i,j))/R_interior)+T(i,j);
            end
            if abs(min(min(T_new(i,j)))-T_final)<10^-3
                disp(t+" is time that one point reaches to 48c")
            end
            if i==1 && 1<j && j<300
                T_new(i,j)=t/Ci*(0.05+2*(0.5*(T(i+1,j)-T(i,j))/R_interior)+(T(i,j-1)-T(i,j))/R_interior+(T(i,j+1)-T(i,j))/R_interior)+T(i,j);
            end
            if abs(min(min(T_new(i,j)))-T_final)<1
                disp(t+" is time that one point reaches to 48c")
            end
            if i==120 && 1<j && j<300
                T_new(i,j)=t/Ci*(0.05+2*(0.5*(T(i-1,j)-T(i,j))/R_interior)+(T(i,j-1)-T(i,j))/R_interior+(T(i,j+1)-T(i,j))/R_interior)+T(i,j);
            end
            if abs(min(min(T_new(i,j)))-T_final)<10^(-3)
                disp(t+" is time that one point reaches to 48c")
            end
            if j==1 && 1<i && i<120
                T_new(i,j)=t/Ci*(0.05+2*((T(i-1,j)-T(i,j))/R_interior)+0.5*((T(i,j+1)-T(i,j))/R_interior)+(T(i+1,j)-T(i,j))/R_interior)+T(i,j);
            
                if abs(min(min(T_new(i,j)))-T_final)<10^(-3)
                    disp(t+" is time that one point reaches to 48c")
                end
            end
            if j==300 && 1<i && i<120
                T_new(i,j)=t/Ci*(00.05+2*((T(i-1,j)-T(i,j))/R_interior)+0.5*((T(i,j-1)-T(i,j))/R_interior)+(T(i+1,j)-T(i,j))/R_interior)+T(i,j);
            end
            if abs(min(min(T_new(i,j)))-T_final)<10^(-3)
                disp(t+" is time that one point reaches to 48c")
            end
            if i==1 && j==1
                T_new(i,j)=t/Ci*(0.05+((T(i+1,j)-T(i,j))/R_interior)+((T(i,j+1)-T(i,j))/R_interior))+T(i,j);
                if abs(min(min(T_new(i,j)))-T_final)<10^(-3)
                disp(t+" is time that one point reaches to 48c")
                end
            end
            if i==120 && j==1
                T_new(i,j)=t/Ci*(0.05+((T(i-1,j)-T(i,j))/R_interior)+((T(i,j+1)-T(i,j))/R_interior))+T(i,j);
               if abs(min(min(T_new(i,j)))-T_final)<10^(-3)
                disp(t+" is time that one point reaches to 48c")
               end
            end
            if i==120 && j==300
                T_new(i,j)=t/Ci*(0.05+((T(i-1,j)-T(i,j))/R_interior)+((T(i,j-1)-T(i,j))/R_interior))+T(i,j);
                if abs(min(min(T_new(i,j)))-T_final)<10^(-3)
                disp(t+" is time that one point reaches to 48c")
                end
            end
            if i==1 && j==300
                T_new(i,j)=t/Ci*(0.05+((T(i+1,j)-T(i,j))/R_interior)+((T(i,j-1)-T(i,j))/R_interior))+T(i,j);
                if abs(min(min(T_new(i,j)))-T_final)<10^(-3)
                disp(t+" is time that one point reaches to 48c")
                end
            end
            T=T_new;
        end
    end
end
