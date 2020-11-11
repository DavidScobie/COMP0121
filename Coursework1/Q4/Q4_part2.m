clear all
close all
%Q4 part 2
%Inversion recovery in rotation frame
%Initial pi pulse along x' axis
% video = VideoSetup('Q4_part2');
% video.open();

mu=0.5;
theta=0;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 200;

B1=mu.*0.3.*[1 0 0];

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
zlim([-0.5 0.5]);
grid on;

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on
 

time_from_start=0;

 vecMu_up=[0 0 0];
 VideoAddFrame(video, h);
 for i=0:noOfSteps-1
    time_from_start=1.*(i+1)./noOfSteps;
    theta=pi./(noOfSteps);
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    h2 = plotSpin3_line_only(time_from_start,i, h1, vecMu,B1,vecMu_up);
    
    hold on
    
    pause(0.002);
%     VideoAddFrame(video, h);
    ClearLinesFromAxes(h2);
 end
 t_end_part_1=time_from_start;
 
%%
%Relaxation up z for time T1

theta=pi;
vecMu0=vecMu;

T1=10;
T2=5;
t=linspace(0,T1,noOfSteps);
relax_time1=T1;

B1=[0 0 0];

for i=0:noOfSteps-1
    
    time_from_start=t_end_part_1+((relax_time1).*(i+1))./noOfSteps;
    
    vecMu(3)=(vecMu0(3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1)); 
    
    h2 = plotSpin3_line_only(time_from_start,i, h1, vecMu,B1,vecMu_up);
    
    pause(0.02);
%     VideoAddFrame(video, h);
    ClearLinesFromAxes(h2);

end
% plotSpin3_line_only(time_from_start,i, h1, vecMu,B1,vecMu_up);
t_end_part_2=time_from_start;

%%
% pi./2 pulse also along x' axis
noOfSteps=50;
B1=mu.*0.3.*[1 0 0];
theta=pi./(noOfSteps.*2);

for i=0:noOfSteps-1
     
    time_from_start=t_end_part_2+((0.5).*(i+1))./noOfSteps;
    
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    h2 = plotSpin3_line_only(time_from_start,i, h1, vecMu,B1,vecMu_up);
    
    hold on
    
    pause(0.005);
%     VideoAddFrame(video, h);
    ClearLinesFromAxes(h2);
 end
B1=[0 0 0];
t_end_part_3=time_from_start;

%%
%Relaxation up along z
noOfSteps=200;
vecMu0=vecMu;
w=0;
relax_time2=3.*T1;
t=linspace(0,relax_time2,noOfSteps);

for i=0:noOfSteps-1
    
    time_from_start=t_end_part_3+((relax_time2).*(i+1))./noOfSteps;
    
    vecMu(1)=exp(-t(i+1)./T2).*((vecMu0(1).*cos(w.*t(i+1)))+(vecMu0(2).*sin(w.*t(i+1))));
    vecMu(2)=exp(-t(i+1)./T2).*((vecMu0(2).*cos(w.*t(i+1)))-(vecMu0(1).*sin(w.*t(i+1))));
    vecMu(3)=(vecMu0(3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));  
    
    h2 = plotSpin3_line_only(time_from_start,i, h1, vecMu,B1,vecMu_up);
    
    hold on
    
    pause(0.05);
%     VideoAddFrame(video, h);
    ClearLinesFromAxes(h2);

end
plotSpin3_line_only(time_from_start,i, h1, vecMu,B1,vecMu_up);
t_end_part_4=time_from_start;
% video.close();





