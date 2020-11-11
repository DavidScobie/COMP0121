%%
clear all
close all
%% create the video writer object
% video = VideoSetup('Q3_part3_vid_neglecting_relaxation');
% video.open();
%Q3 parts 3
mu=0.5;
figure;
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
vecMu=mu.*[0 1 0];
hVecMu = plot3([0 vecMu(1)], [0 vecMu(2)],...
     [0 vecMu(3)],'color','r', 'Linestyle', '-', 'LineWidth', 2);
labelPosition=1.05*B0;
label='B0';
text(labelPosition(1),labelPosition(2),labelPosition(3),label);
labelPosition=1.05*vecMu;
label='\mu';
text(labelPosition(1),labelPosition(2),labelPosition(3),label);
title('Neglecting T1 and T2 relaxation')

% for i=1:200
%     VideoAddFrame(video, h);
%     pause(0.05)
% end
% video.close();
%%
% video = VideoSetup('Q3_part3_vid_including_relaxation');
% video.open();
mu=0.5;
theta=pi./2;
phi=pi./2;

vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
vecMu0=vecMu;

noOfSteps = 500;
w0=(2./3).*pi;
w=0;

h=figure;
h1=subplot(1,1,1);
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
title('With T1 and T2 relaxation')
% VideoAddFrame(video, h);
for i=0:noOfSteps-1
    
    hVecMu = plotSpin3(h1, vecMu);
    
    vecMu(1)=exp(-t(i+1)./T2).*((vecMu0(1).*cos(w.*t(i+1)))+(vecMu0(2).*sin(w.*t(i+1))));
    vecMu(2)=exp(-t(i+1)./T2).*((vecMu0(2).*cos(w.*t(i+1)))-(vecMu0(1).*sin(w.*t(i+1))));
    vecMu(3)=(vecMu0(3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));  
%     VideoAddFrame(video, h);
    pause(0.0005);
    

end
% video.close();