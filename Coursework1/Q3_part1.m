clear all
close all

mu=0.5;
theta=pi./2;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 200;

figure;
h1=subplot(1,1,1)
hold on;
axis equal;
view(100, 10);
xlabel('\mu_x');
ylabel('\mu_y');
zlabel('\mu_z');
xlim([-0.5 0.5]);
ylim([-0.5 0.5]);
zlim([0 0.5]);
grid on;

for i=0:noOfSteps-1
    
    theta=pi./400;
    [vecMu(1),vecMu(2),vecMu(3)]=z_rotation(vecMu(1),vecMu(2),vecMu(3),theta);