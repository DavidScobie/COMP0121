%Question 4
%Free induction decay

clear all
close all
% video = VideoSetup('Q4_part1_rot_frame');
% video.open();
%B1 precession into transverse plane in rotating frame

mu=0.5;
theta=0;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 200;

B1=mu.*0.1.*[1 0 0];

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

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on
plot3([0 B1(1)], [0 B1(2)],...
     [0 B1(3)], 'Linestyle', '-', 'LineWidth', 2);
 hold on

labelPosition=1.05*B0;
label='B0';
text(labelPosition(1),labelPosition(2),labelPosition(3),label);
% VideoAddFrame(video, h);
for i=1:noOfSteps
    
    t_from_start=2.5.*i./200;
    theta=pi./(noOfSteps.*2);
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    plotSpin3(h1, vecMu);
    
    pause(0.005);
    title(['time=',num2str(t_from_start,'%.1f'),'ms']);
%     VideoAddFrame(video, h);
end
%%
hold on

 plot3([0 B1(1)], [0 B1(2)],...
     [0 B1(3)], 'color','w', 'Linestyle', '-', 'LineWidth', 2);
 hold on

theta=pi./2;
phi=pi./2;

vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
vecMu0=vecMu;

noOfSteps = 500;
w0=(2./3).*pi;
w=0;

T1=10;
T2=5;
t=linspace(0,3.*T1,noOfSteps);


for i=0:noOfSteps-1
    
    t_from_start=2.5+t(i+1);
    
    plotSpin3(h1, vecMu);
    
    vecMu(1)=exp(-t(i+1)./T2).*((vecMu0(1).*cos(w.*t(i+1)))+(vecMu0(2).*sin(w.*t(i+1))));
    vecMu(2)=exp(-t(i+1)./T2).*((vecMu0(2).*cos(w.*t(i+1)))-(vecMu0(1).*sin(w.*t(i+1))));
    vecMu(3)=(vecMu0(3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));  
    
    pause(0.0005);
    title(['time=',num2str(t_from_start,'%.1f'),'ms']);
%     VideoAddFrame(video, h);
end
% video.close();
