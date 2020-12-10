%First the B1 flip
clear all
close all
set(0,'DefaultLegendAutoUpdate','off')

mu=0.5;
theta=0;
phi=pi./2;

N=256;
GMax=4.6;
Ts=5.12;
noOfSteps = 16;
L=20;
spin_spacing=1;
no_of_spins = 17;

vecMus0=zeros(3,no_of_spins);
vecMus0orig=zeros(3,no_of_spins);

%The initial spin vector magnitudes
vecMus0=[-10,-5,0,-10,-5,0,-10,-5,0,5,10,0,5,10,0,5,10;-10,-10,-10,-5,-5,-5,0,0,0,0,0,5,5,5,10,10,10;0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];
vecMusReset=vecMus0;

%The initial spin vector origins
vecMus0orig(1:2,:)=vecMus0(1:2,:);
vecMus0orig(3,:)=zeros(1,no_of_spins);

h = figure;
h1=subplot(1,1,1);
hold on;
axis equal;
view(100, 10);
xlabel('x');
ylabel('y');
zlabel('z');
xlim([-11 11]);
ylim([-11 11]);
zlim([0 0.5]);
grid on;

stage=1;
t=0;

for i=0:noOfSteps-1
    
    t=(i+1).*0.02;
    
    theta=pi./32;

    
    %calculate the vectors of each spin
    for k = 1:no_of_spins
        
        %Moving initial vector to near origin
        vecMusInit(1,k)=vecMusReset(1,k)-vecMus0orig(1,k);
        vecMusInit(2,k)=vecMusReset(2,k)-vecMus0orig(2,k);
        vecMusInit(3,k)=vecMusReset(3,k)-vecMus0orig(3,k);;
        
        %x rotation
        [vecMusRot(1,k),vecMusRot(2,k),vecMusRot(3,k)]=x_rotation(vecMusInit(1,k),vecMusInit(2,k),vecMusInit(3,k),theta);
        
        %Resetting position to actual
        vecMusReset(1,k)=vecMusRot(1,k)+vecMus0orig(1,k);
        vecMusReset(2,k)=vecMusRot(2,k)+vecMus0orig(2,k); 
        vecMusReset(3,k)=vecMusRot(3,k)+vecMus0orig(3,k); 
    end
    
    %Plot the spin vectors
    hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t,h1,vecMus0orig,vecMusReset);
    
       
    pause(0.1);
    
    ClearLinesFromAxes(h1);

end
plotSpin3D_2Dgrid(stage,no_of_spins,t,h1,vecMus0orig,vecMusReset);

%%
%Gy is on for Ts, this is the phase encoding gradient

%Redefine the axes to 2D now
delete(h1)
h1=subplot(1,1,1);
hold on;
axis equal;
xlabel('x');
ylabel('y');
xlim([-11 11]);
ylim([-11 11]);
grid on;

set(0,'DefaultLegendAutoUpdate','off')

vecMus2start=vecMusReset(1:2,:);
T2=10;

stage=2;
Gy=4.6;

wy=zeros(no_of_spins);
for i = 1:no_of_spins
    wy(i)=(9.2./10).*(vecMus0orig(2,i));
end    


for i = 1:N
    
    t_from_start=0.32+(i.*(Ts./N));
    t=(i.*(Ts./N));
    ky1=0.1.*Gy.*t;
    
    for k = 1:no_of_spins
        %Moving initial vector to near origin
        vecMus2init(1,k)=vecMus2start(1,k)-vecMus0orig(1,k);
        vecMus2init(2,k)=vecMus2start(2,k)-vecMus0orig(2,k);
        
        %Bloch equations
        vecMus2rot(1,k)=exp((-t)./T2).*((vecMus2init(1,k).*cos(wy(k).*t))+((vecMus2init(2,k).*(sin(wy(k).*t)))));
        vecMus2rot(2,k)=exp((-t)./T2).*((vecMus2init(2,k).*cos(wy(k).*t))-((vecMus2init(1,k).*(sin(wy(k).*t)))));
        
        %Resetting position to actual
        vecMus2reset(1,k)=vecMus2rot(1,k)+vecMus0orig(1,k);
        vecMus2reset(2,k)=vecMus2rot(2,k)+vecMus0orig(2,k);       
    end
    
    hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus2reset);
    legend(h1,'hide')
    
    pause(0.001);
    
    ClearLinesFromAxes(h1);
end
plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus2reset);

%%
%Gx is on for Ts/2, this is the dephasing lobe of the readout gradient 

vecMus3start=vecMus2reset;
Gx=-4.6;
T2=10;

wx=zeros(no_of_spins);
for i = 1:no_of_spins
    wx(i)=(9.2./10).*(vecMus0orig(1,i));
end 

for i = 1:N
    
    t_from_start=(0.32+Ts)+(i.*(Ts./N));
    t=(i.*(Ts./N));
    kx1=0.1.*Gx.*t;
    
    for k = 1:no_of_spins
        %Moving initial vector to near origin
        vecMus3init(1,k)=vecMus3start(1,k)-vecMus0orig(1,k);
        vecMus3init(2,k)=vecMus3start(2,k)-vecMus0orig(2,k);
        
        %Bloch equations
        vecMus3rot(1,k)=exp((-t)./T2).*((vecMus3init(1,k).*cos(wx(k).*t))+((vecMus3init(2,k).*(sin(wx(k).*t)))));
        vecMus3rot(2,k)=exp((-t)./T2).*((vecMus3init(2,k).*cos(wx(k).*t))-((vecMus3init(1,k).*(sin(wx(k).*t)))));
        
        %Resetting position to actual
        vecMus3reset(1,k)=vecMus3rot(1,k)+vecMus0orig(1,k);
        vecMus3reset(2,k)=vecMus3rot(2,k)+vecMus0orig(2,k);       
    end
    
    hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus3reset);
    legend(h1,'hide')
    
    pause(0.01);
    
    ClearLinesFromAxes(h1);
end
plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus3reset);
