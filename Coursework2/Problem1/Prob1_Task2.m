clear all
close all
set(0,'DefaultLegendAutoUpdate','off')

mu=0.5;
theta=0;
phi=pi./2;
noOfSteps = 16;
deltaT = 0.01;

L=20;
spin_spacing=1;
no_of_spins=(L./spin_spacing)+1;

vecMus0=zeros(3,no_of_spins);

for i = 1:no_of_spins
    vecMus0(1:3,i) = mu*[cos(phi)*sin(theta)+((2.*i)-(no_of_spins+1)) sin(phi)*sin(theta) cos(theta)]';
end
vecMus=vecMus0;
vecMu = mu*[cos(phi)*sin(theta)+10 sin(phi)*sin(theta) cos(theta)]';

h = figure;
h1=subplot(2,2,1);
hold on;
axis equal;
view(100, 10);
xlabel('x');
ylabel('y');
zlabel('z');
xlim([-L./2 L./2]);
ylim([-0.5 0.5]);
zlim([0 0.5]);
grid on;

h3 = subplot(2,2,3);
hold on;
xlabel('time (ms)');
ylabel('G_x,G_y');
xlim([0, 5.44]);
ylim([-5 5]);
grid on; 

h4 = subplot(2,2,4);
hold on;
xlabel('time (ms)');
ylabel('k_x,k_y');
xlim([0, 5.44]);
ylim([-3 3]);
grid on; 

Gx=0;
Gy=0;

kx=0;
ky=0;

stage=1;
t=0;

for i=0:noOfSteps-1
    
    t=(i+1).*0.02;
    
    theta=pi./32;
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    %calculate the vectors of each spin
    for i = 1:no_of_spins
        [vecMus(1,i),vecMus(2,i),vecMus(3,i)]=x_rotation(vecMus(1,i),vecMus(2,i),vecMus(3,i),theta);
    end
    
    %Plot the spin vectors
    hVecMu = plotSpin3D_1Dline(stage,no_of_spins,t,h1, vecMus);
    
    
    plot(h3,t,Gx,'Color','b','Marker', '.', 'MarkerSize', 10,'DisplayName','M_x');
    %     legend('k_t_o_t');
    hold on
    plot(h3,t,Gy,'Color','r','Marker', '.', 'MarkerSize', 10,'DisplayName','M_y');
    hold on
 
    
    plot(h4,t,kx,'Color','b','Marker', '.', 'MarkerSize', 10,'DisplayName','k_x');
    %     legend('k_t_o_t');
    hold on
    plot(h4,t,ky,'Color','r','Marker', '.', 'MarkerSize', 10,'DisplayName','k_y');
    hold on
  
    
    pause(0.1);
    
    ClearLinesFromAxes(h1);

end

%%

%Redefine the axes to 2D now
delete(h1)
h1=subplot(2,2,1);
hold on;
axis equal;
xlabel('x');
ylabel('y');
xlim([-L./2 L./2]);
ylim([-L./2 L./2]);
grid on;

set(0,'DefaultLegendAutoUpdate','off')

vecMus2=vecMus(1:2,:);
T2=10;
N=256;
Ts=5.12;
stage=2;
Gx=-4.6;

w=linspace(-4.*Gx,4.*Gx,no_of_spins);

h2 = subplot(2,2,2);
hold on;
xlabel('time (ms)');
ylabel('M_x,M_y');
xlim([0, 0.32]);
ylim([-1 1]);
grid on; 

%Change Mtrans time axes limit
xlim(h2,[0 Ts+0.32])

%Calculating transverse magnetisation
for i = 1:no_of_spins
    Mx(i)=vecMus(1,i)-vecMus0(1,i);
    My(i)=vecMus(2,i)-vecMus0(2,i);
end
Mxtot=sum(Mx./(no_of_spins.*mu));
Mytot=sum(My./(no_of_spins.*mu));

hMTrans = plot_Task1_MTrans(t,h2,Mxtot,Mytot);

for i = 1:N
    
    t=0.32+(i.*(Ts./N));
    kx=0.1.*Gx.*t;
    
    for k = 1:no_of_spins
        vecMus3(1,k)=exp((-t)./T2).*((vecMus2(1,11).*cos(w(k).*t))+((vecMus2(2,11).*(sin(w(k).*t)))));
        vecMus3(2,k)=exp((-t)./T2).*((vecMus2(2,11).*cos(w(k).*t))-((vecMus2(1,11).*(sin(w(k).*t)))));
        
        vecMus4(1,k)=vecMus3(1,k)+vecMus2(1,k);
        vecMus4(2,k)=vecMus3(2,k);        
    end
     
    hVecMu = plotSpin3D_1Dline(stage,no_of_spins,t,h1, vecMus4);
    legend(h1,'hide')
    %Calculating transverse magnetisation
    for i = 1:no_of_spins    
        Mx(i)=vecMus4(1,i)-vecMus2(1,i);
        My(i)=vecMus4(2,i);
    end
    Mxtot=sum(Mx./(no_of_spins.*mu));
    Mytot=sum(My./(no_of_spins.*mu));
    
    hMTrans = plot_Task1_MTrans(t,h2,Mxtot,Mytot);
    
    
    plot(h3,t,Gx,'Color','b','Marker', '.', 'MarkerSize', 10,'DisplayName','M_x');
    %     legend('k_t_o_t');
    hold on
    plot(h3,t,Gy,'Color','r','Marker', '.', 'MarkerSize', 10,'DisplayName','M_y');
    hold on
    
    
    plot(h4,t,kx,'Color','b','Marker', '.', 'MarkerSize', 10,'DisplayName','k_x');
    %     legend('k_t_o_t');
    hold on
    plot(h4,t,ky,'Color','r','Marker', '.', 'MarkerSize', 10,'DisplayName','k_y');
    hold on    
    
    
    pause(0.001);
    
    ClearLinesFromAxes(h1);
end
hVecMu = plotSpin3D_1Dline(stage,no_of_spins,t,h1, vecMus4);    
        

%%









        
        
        
        
        


