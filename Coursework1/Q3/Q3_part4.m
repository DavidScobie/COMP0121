%%
%Question 3 part 4
clear all
close all

% video = VideoSetup('Q3_part4_vid_neglecting_relaxation');
% video.open();

noOfSteps = 500;
mu=0.5;
h=figure;
h0=subplot(1,1,1)
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

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
 
labelPosition=1.05*B0;
label='B0';
text(labelPosition(1),labelPosition(2),labelPosition(3),label);

% VideoAddFrame(video, h);
vecMu=mu.*[0 1 0];
w=0.05.*2.*pi;
rot_ang=(w.*noOfSteps)./17000;
title('Neglecting T1 and T2 relaxation')

for i=0:noOfSteps-1
    
    [vecMu(1),vecMu(2),vecMu(3)]=z_rotation(vecMu(1),vecMu(2),vecMu(3),rot_ang);
    
    hVecMu = plotSpin3(h0, vecMu)
    pause(0.0005);
%     VideoAddFrame(video, h);
end
% video.close();
 



%%
% video = VideoSetup('Q3_part4_vid_including_relaxation');
% video.open();

mu=0.5;
theta=pi./2;
phi=pi./2;

vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
vecMu0=vecMu;

noOfSteps = 500;
w0=(2./3).*pi;
w=0.1.*w0;

h=figure;
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

T1=10;
T2=5;
t=linspace(0,3.*T1,noOfSteps);

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on

labelPosition=1.05*B0;
label='B0';
text(labelPosition(1),labelPosition(2),labelPosition(3),label);
 
title('Including T1 and T2 relaxation')
% VideoAddFrame(video, h);

for i=0:noOfSteps-1
    
    hVecMu = plotSpin3(h1, vecMu);
    
    vecMu(1)=exp(-t(i+1)./T2).*((vecMu0(1).*cos(w.*t(i+1)))+(vecMu0(2).*sin(w.*t(i+1))));
    vecMu(2)=exp(-t(i+1)./T2).*((vecMu0(2).*cos(w.*t(i+1)))-(vecMu0(1).*sin(w.*t(i+1))));
    vecMu(3)=(vecMu0(3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));  
    
    pause(0.0005);
   
%     VideoAddFrame(video, h);
end
% video.close();