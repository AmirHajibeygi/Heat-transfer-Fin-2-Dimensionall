clc
clear
disp("In the name of God")
rho_air=1.13076;%kg/m^3
Re=51.4377;
pr=0.70514;
k_cu=386;
T_air=40;%c
T_water=30;%c
k=0.0272254;%w/m*c
h=1.79;%w/m^2*c 
Gr=4.24343*10^9;
Grpr=2.17264*10^10;
Nu_w=382.876;
h_w=800;%w/m^2*c
T=300*ones(120,300);%c
D_x=0.001;
k_st=44.5;%w/m*c
k_av=(386+44.5)/2;
%%boundary conditions
for i=1:120
     T(i,300)=35;
end
error=2;
tolerance=10^(-5);
T_old=T;
T_cu=ones(400,100);
T_old_cu=T_cu;
%we calculate interior points in this part
%At first we should calculate boundary points of cu
while error >tolerance
    for i=1:400
        for j=1:100
            if 1<i && i<400 && 1<j && j<50 
                T_cu(i,j)=(T_cu(i+1,j)+T_cu(i,j+1)+T_cu(i-1,j)+T_cu(i,j-1))/4;
            end
            if 1==i && 1<j && j<50
                  T_cu(i,j)=2/(5+h_w*D_x/k_cu)*(T_cu(i,j+1)+T_cu(i,j-1)+0.5*T_cu(i+1,j))+(h_w*D_x/k_cu)/(5+h_w*D_x/k_cu)*T_water;
            end
            if 1==i && 50<j && j<100
                  T_cu(i,j)=2/(5+h_w*D_x/k_cu)*(T_cu(i,j+1)+T_cu(i,j-1)+0.5*T_cu(i+1,j))+(h_w*D_x/k_cu)/(5+h_w*D_x/k_cu)*T_water;
            end
            if 400==i && 50<j && j<100
                  T_cu(i,j)=2/(5+h*D_x/k_st)*(T_cu(i,j+1)+T_cu(i,j-1)+0.5*T_cu(i-1,j))+(h*D_x/k_st)/(5+h*D_x/k_st)*T_air;
            end
            if i==400 && 1<j && j<50
                  T_cu(i,j)=2/(5+h*D_x/k_st)*(T_cu(i,j+1)+T_cu(i,j-1)+0.5*T_cu(i-1,j))+(h*D_x/k_st)/(5+h*D_x/k_st)*T_air;
            end
            if j==1 && i<400 && i>1 
                  T_cu(i,j)=0.2*T_cu(i,j+1)+0.4*T_cu(i+1,j)+0.4*T_cu(i-1,j);
            end
            if j==100 && i<140 && i>1
                  T_cu(i,j)=2/(5+h_w*D_x/k_cu)*(T_cu(i+1,j)+T_cu(i-1,j)+0.5*T_cu(i,j-1))+(h_w*D_x/k_cu)/(5+h_w*D_x/k_cu)*T_water;
            end
            if j==100 && i>260 && i<400
                 T_cu(i,j)=2/(5+h*D_x/k_st)*(T_cu(i-1,j)+T_cu(i+1,j)+0.5*T_cu(i,j-1))+(h*D_x/k_st)/(5+h*D_x/k_st)*T_air;
            end
            if i>1 && i<140 && j>50 && j<100
                 T_cu(i,j)=(T_cu(i+1,j)+T_cu(i,j+1)+T_cu(i-1,j)+T_cu(i,j-1))/4;
            end
            if i>260 && i<400 && j>50 && j<100
                 T_cu(i,j)=(T_cu(i+1,j)+T_cu(i,j+1)+T_cu(i-1,j)+T_cu(i,j-1))/4;
            end
            if i==120 && j==300
                 T(i,j)=0.5*(T(i-1,j)+T(i,j-1));
            end
            if 140<i && i<260 && j==50
                    T_cu(i,j)=0.448*T_cu(i,j-1)+0.051684*T(i-140,j-49)+0.25*T_cu(i+1,j)+0.25*T_cu(i-1,j);
            end
            if i==260 && j<100 && j>50
            T_cu(i,j)=0.25*T_cu(i,j-1)+0.25*T_cu(i,j+1)+0.448*T_cu(i+1,j)+0.051684*T(i-141,j);
            end
            if i==140 && j<100 && j>50
            T_cu(i,j)=0.25*T_cu(i,j-1)+0.25*T_cu(i,j+1)+0.448*T_cu(i-1,j)+0.051684*T(i-139,j);
            end
            if i==1 && j==1
                T_cu(i,j)=(T_cu(i+1,j)+T_cu(i,j+1))/2;
            end
            if i==400 && j==1
                T_cu(i,j)=(T_cu(i-1,j)+T_cu(i,j+1))/2;
            end
            if i==1 && j==100
                T_cu(i,j)=(T_cu(i+1,j)+T_cu(i,j-1))/2;
            end
            if i==400 && j==100
                T_cu(i,j)=(T_cu(i-1,j)+T_cu(i,j-1))/2;
            end
            if j==50 && i>1 && i<140
                T_cu(i,j)=(T_cu(i+1,j)+T_cu(i,j+1)+T_cu(i-1,j)+T_cu(i,j-1))/4;
            end
            if j==50 && i>260 && i<400
                T_cu(i,j)=(T_cu(i+1,j)+T_cu(i,j+1)+T_cu(i-1,j)+T_cu(i,j-1))/4;
            end
        end
    end
    error=max(max(abs(T_cu-T_old_cu)));
    T_old_cu=T_cu;
end
error2=1;
tolerance2=10^(-8);
while error2 >tolerance2
    for i=1:120
        for j=1:300
            if 1<i && i<120 && 1<j && j<300 
                T(i,j)=(T(i+1,j)+T(i,j+1)+T(i-1,j)+T(i,j-1))/4;
            end
            if 1==i && 50<j && j<300
                  T(i,j)=(T(i+1,j)+(T(i,j+1)+T(i,j-1))/2+(h_w*D_x/k_st)*T_water)/(2+h_w*D_x/k_st*T_water);
            end
            if i==120 && 50<j && j<300
                  T(i,j)=(T(i-1,j)+(T(i,j+1)+T(i,j-1))/2+(h*D_x/k_st)*T_air)/(2+h*D_x/k_st*T_air);
            end
            if i==120 && 1<j && j<50
                  T(i,j)=0.05396*T(i-1,j)+0.446*T_cu(i+141,j)+0.25*T(i,j+1)+0.25*T(i,j-1);
            end
            if i==1 && 1<j && j<50 
                  T(i,j)=0.05396*T_cu(i+139,j)+0.446*T(i+1,j)+0.25*T(i,j+1)+0.25*T(i,j-1);
            end
            if i==1 && j==1
                 T(i,j)=0.5*(T(i+1,j)+T(i,j+1));
            end
            if i==120 && j==1
                 T(i,j)=0.25*(T(i-1,j)+T(i,j+1)+T_cu(i+141,j+50)+T_cu(i+140,j+48));
            end
            if i==1 && j==300
                 T(i,j)=0.5*(T(i,j-1)+T(i+1,j));
            end
            if i==120 && j==300
                 T(i,j)=0.5*(T(i-1,j)+T(i,j-1));
            end
            if i==1 && j==50%TTTTTTTTTTTT
            T(i,j)=0.4*(T(i,j-1)+T(i,j+1)+0.5*T(i+1,j))+(h_w*D_x/(k_st*5))*(-T(i,j)+T_water);
            end
            if i==120 && j==50%tttttttttttt
            T(i,j)=0.4*(T(i,j-1)+T(i,j+1)+0.5*T(i-1,j))+(h*D_x/(k_st*5))*(-T(i,j)+T_air);
            end
            if j==1 && i<120 && i>1
                T(i,j)=0.44*T_cu(i+140,j+50)+0.25*T(i-1,j)+0.25*T(i+j)+0.05168*T(i,j+1);
            end
        end
    end
    error2=max(max(abs(T-T_old)));
    T_old=T;
end
%%%plotting
T_draw=T(:,50);
Y=zeros(120,1);
for i=2:121
    Y(i-1,1)=0.1*(i-1);
end
xlabel('x')
ylabel('temperature')
plot(Y,T_draw)
%%%%%second part