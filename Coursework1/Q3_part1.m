clear all
close all
%Q3 parts 1 and 2
mu=0.5;
theta=pi./2;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 1000;

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




T1=4;
T2=40;
times=linspace(0,T1,noOfSteps);
disp(vecMu)

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on
plot3([0 vecMu(1)], [0 vecMu(2)],...
     [0 vecMu(3)], 'Linestyle', '-', 'LineWidth', 2);
 hold on


for i=0:noOfSteps-1
    phi=pi./30;
    hVecMu = plotSpin3(h1, vecMu);
    
    [vecMu(1),vecMu(2),vecMu(3)]=z_rotation(vecMu(1),vecMu(2),vecMu(3),phi);
    vecMu(1)=exp(-times(i+1)./T2).*vecMu(1);
    vecMu(2)=exp(-times(i+1)./T2).*vecMu(2);
    vecMu(3)=(exp(-times(i+1)./T1).*vecMu(3))+mu.*(1-exp(-times(i+1)./T1));
    
    
    
    
    pause(0.0005);
    
    delete(hVecMu);
    
    plotSpin3(h1, vecMu);
%     
    
    
    mag(i+1)=sqrt(vecMu(1).^2+vecMu(2).^2+vecMu(3).^2);
%     magxy(i+1)=sqrt(vecMu(1).^2+vecMu(2));
end
disp('done')
%%
%Q3 part 3

mu=0.5;
theta=pi./2;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 1000;

figure;
h1=subplot(1,1,1)
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




T1=4;
T2=8;
times=linspace(0,T1./2,noOfSteps);
disp(vecMu)

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on
plot3([0 vecMu(1)], [0 vecMu(2)],...
     [0 vecMu(3)], 'Linestyle', '-', 'LineWidth', 2);
 hold on


for i=0:noOfSteps-1
    phi=pi./30;
    hVecMu = plotSpin3(h1, vecMu);
    
    
    vecMu(1)=exp(-times(i+1)./T2).*vecMu(1);
    vecMu(2)=exp(-times(i+1)./T2).*vecMu(2);
    vecMu(3)=(exp(-times(i+1)./T1).*vecMu(3))+mu.*(1-exp(-times(i+1)./T1));
    
    
    
    
    pause(0.0005);
    
    delete(hVecMu);
    
    plotSpin3(h1, vecMu);
%     
    
    
    mag(i+1)=sqrt(vecMu(1).^2+vecMu(2).^2+vecMu(3).^2);
%     magxy(i+1)=sqrt(vecMu(1).^2+vecMu(2));
end
disp('plot 2 done')
%%
%Question 3 part 4
%Q3 part 3
mu=0.5;
theta=pi./2;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 1000;

figure;
h1=subplot(1,1,1)
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




T1=4;
T2=40;
times=linspace(0,T1,noOfSteps);
disp(vecMu)

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on
plot3([0 vecMu(1)], [0 vecMu(2)],...
     [0 vecMu(3)], 'Linestyle', '-', 'LineWidth', 2);
 hold on


for i=0:noOfSteps-1
    phi=pi./200;
    hVecMu = plotSpin3(h1, vecMu);
    
    [vecMu(1),vecMu(2),vecMu(3)]=z_rotation(vecMu(1),vecMu(2),vecMu(3),phi);
    vecMu(1)=exp(-times(i+1)./T2).*vecMu(1);
    vecMu(2)=exp(-times(i+1)./T2).*vecMu(2);
    vecMu(3)=(exp(-times(i+1)./T1).*vecMu(3))+mu.*(1-exp(-times(i+1)./T1));
    
    
    
    
    pause(0.0005);
    
    delete(hVecMu);
    
    plotSpin3(h1, vecMu);
%     
    
    
    mag(i+1)=sqrt(vecMu(1).^2+vecMu(2).^2+vecMu(3).^2);
%     magxy(i+1)=sqrt(vecMu(1).^2+vecMu(2));
end
disp('plot 3 done')

%%
%Question 3 part 5
%Q3 part 5
mu=0.5;
theta=pi./2;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 1000;

figure;
h1=subplot(1,1,1)
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




T1=4;
T2=40;
times=linspace(0,T1,noOfSteps);
disp(vecMu)

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on
plot3([0 vecMu(1)], [0 vecMu(2)],...
     [0 vecMu(3)], 'Linestyle', '-', 'LineWidth', 2);
 hold on


for i=0:noOfSteps-1
    phi=-pi./200;
    hVecMu = plotSpin3(h1, vecMu);
    
    [vecMu(1),vecMu(2),vecMu(3)]=z_rotation(vecMu(1),vecMu(2),vecMu(3),phi);
    vecMu(1)=exp(-times(i+1)./T2).*vecMu(1);
    vecMu(2)=exp(-times(i+1)./T2).*vecMu(2);
    vecMu(3)=(exp(-times(i+1)./T1).*vecMu(3))+mu.*(1-exp(-times(i+1)./T1));
    
    
    
    
    pause(0.0005);
    
    delete(hVecMu);
    
    plotSpin3(h1, vecMu);
%     
    
    
    mag(i+1)=sqrt(vecMu(1).^2+vecMu(2).^2+vecMu(3).^2);
%     magxy(i+1)=sqrt(vecMu(1).^2+vecMu(2));
end
disp('plot 4 done')
    
    