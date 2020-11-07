%%Question 2 part 4
clear all
close all

mu=0.5;
theta=0;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 200;
deltaT = 0.01;

figure;
h1=subplot(2,2,1)
hold on;
axis equal;
view(100, 10);
xlabel('\mu_x''');
ylabel('\mu_y''');
zlabel('\mu_z');
xlim([-0.5 0.5]);
ylim([-0.5 0.5]);
zlim([0 0.5]);
grid on;

h3 = subplot(2,2,3);
hold on;
xlabel('time (ms)');
ylabel('\mu_z');
xlim([0, noOfSteps*deltaT./2]);
ylim([-0.5 0.5]);
grid on;

h4 = subplot(2,2,4);
hold on;
xlabel('time (ms)');
ylabel('\mu_y''');
xlim([0, noOfSteps*deltaT./2]);
ylim([-0.5 0.5]);
grid on; 

for i=0:noOfSteps-1
    
    theta=pi./400;
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    deltaT=i./200;
    
    hVecMu = plotSpin3D(h1, vecMu);
    h_muz_t = plotSpinh_muz_t(h3,vecMu,deltaT);
    h_muy_t = plotSpinh_muy_t(h4,vecMu,deltaT);
    
    pause(0.05);
    
    delete(hVecMu);
    delete(h_muz_t);
    delete(h_muy_t);
    
    plotSpin3D(h1, vecMu);
    plotSpinh_muz_t(h3,vecMu,deltaT);
    plotSpinh_muy_t(h4,vecMu,deltaT);
    
end