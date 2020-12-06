clear all
close all

mu=0.5;
theta=0;
phi=pi./2;
noOfSteps = 20;
deltaT = 0.01;

L=20;
spin_spacing=1;
no_of_spins=(L./spin_spacing)+1;

vecMus=zeros(3,no_of_spins);

for i = 1:no_of_spins
    vecMus(1:3,i) = mu*[cos(phi)*sin(theta)+((2.*i)-(no_of_spins+1)) sin(phi)*sin(theta) cos(theta)]';
end
vecMu = mu*[cos(phi)*sin(theta)+10 sin(phi)*sin(theta) cos(theta)]';

h = figure;
h1=subplot(1,1,1)
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

% h4 = subplot(2,2,4);
% hold on;
% xlabel('time (ms)');
% ylabel('\mu_y''');
% xlim([0, noOfSteps*deltaT./2]);
% ylim([-0.5 0.5]);
% grid on; 

t=0;

for i=0:noOfSteps-1
    
    t=i./noOfSteps;
    
    theta=pi./40;
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    for i = 1:no_of_spins
        [vecMus(1,i),vecMus(2,i),vecMus(3,i)]=x_rotation(vecMus(1,i),vecMus(2,i),vecMus(3,i),theta);
    end
    
%     hVecMu = plotSpin3D(t,h1, vecMu);
    j=size(vecMus);
    k=j(2)

    hVecMu = plotSpin3D_1Dline(no_of_spins,t,h1, vecMus);
    pause(0.1);
        
%     h_muy_t = plotSpinh_muy_t(h4,vecMu,t);   
    
    ClearLinesFromAxes(h1);
end
plotSpin3D_1Dline(no_of_spins,t,h1, vecMus);
plotSpinh_muy_t(h4,vecMu,t);