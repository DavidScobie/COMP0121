clear all
close all
%Q4 part 2
%Inversion recovery in rotation frame
%Initial pi pulse along x' axis

mu=0.5;
theta=0;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 200;

B1=mu.*0.1.*[1 0 0];

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
zlim([-0.5 0.5]);
grid on;

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on
 
 vecMu_up=[0 0 0];
 
 for i=0:noOfSteps-1
    
    theta=pi./(noOfSteps);
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    h2 = plotSpin3_line_only(i, h1, vecMu,B1,vecMu_up);
    
    hold on
    
    pause(0.002);
    
    ClearLinesFromAxes(h2);
 end
%%
%Relaxation up z for time T1

theta=pi;
vecMu0=vecMu;

T1=10;
T2=5;
t=linspace(0,T1,noOfSteps);

B1=[0 0 0];

for i=0:noOfSteps-1
    
    vecMu(3)=(vecMu0(3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1)); 
    
    h2 = plotSpin3_line_only(i, h1, vecMu,B1,vecMu_up);
    
    pause(0.02);
    
    ClearLinesFromAxes(h2);

end
plotSpin3_line_only(i, h1, vecMu,B1,vecMu_up);

%%
% pi./2 pulse also along x' axis
noOfSteps=50;
B1=mu.*0.1.*[1 0 0];
theta=pi./(noOfSteps.*2);

for i=0:noOfSteps-1
     
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    h2 = plotSpin3_line_only(i, h1, vecMu,B1,vecMu_up);
    
    hold on
    
    pause(0.005);
    
    ClearLinesFromAxes(h2);
 end
B1=[0 0 0];

%%
%Relaxation up along z
noOfSteps=200;
vecMu0=vecMu;
w=0;
t=linspace(0,3.*T1,noOfSteps);

for i=0:noOfSteps-1
    
    vecMu(1)=exp(-t(i+1)./T2).*((vecMu0(1).*cos(w.*t(i+1)))+(vecMu0(2).*sin(w.*t(i+1))));
    vecMu(2)=exp(-t(i+1)./T2).*((vecMu0(2).*cos(w.*t(i+1)))-(vecMu0(1).*sin(w.*t(i+1))));
    vecMu(3)=(vecMu0(3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));  
    
    h2 = plotSpin3_line_only(i, h1, vecMu,B1,vecMu_up);
    
    hold on
    
    pause(0.05);
    
    ClearLinesFromAxes(h2);

end
plotSpin3_line_only(i, h1, vecMu,B1,vecMu_up);







