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

% vecMus=vecMus0;

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