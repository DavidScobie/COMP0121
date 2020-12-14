%Q5 part 1
clear all 
close all

%% create the video writer object
% video = VideoSetup('Q5_part1_vid2');
% video.open();
%%

%Initial pi./2 pulse flip to y' plane
mu=0.5;
theta=0;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 200;

T1=10;
T2=5;

h = figure;
h1=subplot(2,2,1);
hold on;
axis equal;
view(100, 10);
xlabel('M_x''');
ylabel('M_y''');
zlabel('M_z');
xlim([-0.5 0.5]);
ylim([-0.5 0.5]);
zlim([-0.5 0.5]);
grid on;

h2_1 = subplot(2,2,3);
hold on;
xlabel('time (ms)');
ylabel('M_{\perp}/M_{\perp}_{max}');
xlim([0, 1.5+((19./6).*T1)]);
ylim([0 1]);
grid on;

h3_1 = subplot(2,2,4);
hold on;
xlabel('M_x''');
ylabel('M_y''');
xlim([-mu mu]);
ylim([-mu mu]);
grid on;

t_from_start=0;
% VideoAddFrame(video, h);
stage=1;
for i=0:noOfSteps-1
    
    t_from_start=((0.5).*(i+1))./noOfSteps;
    
    theta=pi./(noOfSteps.*2);
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    M_trans=sum(vecMu(1:2))./mu;
    
    h2_2 = plot(h2_1,t_from_start,M_trans,...
      'Color', 'r', 'Marker', '.', 'MarkerSize', 10);
    hold on
    
    h3_2 = plot_Q5_p1_trans_plane(stage, h3_1, vecMu);
    hold on
    
    h2 = plot_Q5_p1_spins(stage, h1, vecMu);
    hold on
    
%     VideoAddFrame(video, h);
    pause(0.001);
    
    ClearLinesFromAxes(h2)
    ClearLinesFromAxes(h3_2)
    
end

t_end_part_1=t_from_start;
%%
%T1 relaxation up z slightly and spin dephasing

noOfSpins=11;
vecMus=zeros(noOfSpins,3);
vecMuSize=size(vecMus);

for i=1:vecMuSize(1)
     vecMus(i,:)=vecMu;
end
 
noOfSteps=100;
relax_time1=T1./6;
t=linspace(0,relax_time1,noOfSteps);
vecMus0=vecMus;
wmax=pi;
w=linspace(-wmax,wmax,noOfSpins);

M_trans=zeros(noOfSteps,1);

stage=2;
for i=0:noOfSteps-1
    
    t_from_start=t_end_part_1+((relax_time1).*(i+1))./noOfSteps;
    
    for k=1:noOfSpins
     
        vecMus(k,1)=exp(-t(i+1)./T2).*((vecMus0(k,1).*cos(w(k).*t(i+1)))+(vecMus0(k,2).*sin(w(k).*t(i+1))));
        vecMus(k,2)=exp(-t(i+1)./T2).*((vecMus0(k,2).*cos(w(k).*t(i+1)))-(vecMus0(k,1).*sin(w(k).*t(i+1))));
        vecMus(k,3)=(vecMus0(k,3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));
    
    end
    
    M_trans=(sum(sum(vecMus(:,1:2))))./(mu.*noOfSpins);
    h2_2 = plot(h2_1,t_from_start,M_trans,...
        'Color', 'r', 'Marker', '.', 'MarkerSize', 10);
    hold on
    
    h3_2 = plot_Q5_p1_trans_plane(stage, h3_1, vecMu, vecMus);
    hold on
    
    h3 = plot_Q5_p1_spins(stage, h1, vecMu, vecMus);
    hold on
    
%     VideoAddFrame(video, h);
    pause(0.0005);
    
    ClearLinesFromAxes(h3_2);
    ClearLinesFromAxes(h3);
    
end

t_end_part_2=t_from_start;
%%
%pi pulse along y' causes flip around y' axis
noOfSteps=100;
theta=pi./(noOfSteps);

for i=0:noOfSteps-1
    
    t_from_start=t_end_part_2+((1).*(i+1))./noOfSteps;
    
    for k=1:noOfSpins
        [vecMus(k,1),vecMus(k,2),vecMus(k,3)]=y_rotation(vecMus(k,1),vecMus(k,2),vecMus(k,3),theta);
    end
    
    M_trans=(sum(sum(vecMus(:,1:2))))./(mu.*noOfSpins);
    
    h2_2 = plot(h2_1,t_from_start,M_trans,...
        'Color', 'r', 'Marker', '.', 'MarkerSize', 10);
    hold on
    
    h3_2 = plot_Q5_p1_trans_plane(stage, h3_1, vecMu, vecMus);
    hold on
    
    h3 = plot_Q5_p1_spins(stage, h1, vecMu, vecMus);
    
    hold on
    
%     VideoAddFrame(video, h);
    pause(0.0002);
    
    ClearLinesFromAxes(h3_2);
    ClearLinesFromAxes(h3);
    
end

t_end_part_3=t_from_start;
%%
% Relaxation causing echo along y' axis
noOfSteps=200;
vecMus1=vecMus;
relax_time2=3.*T1;
t=linspace(0,relax_time2,noOfSteps);

for i=0:noOfSteps-1
    
    t_from_start=t_end_part_3+((relax_time2).*(i+1))./noOfSteps;
    
    for k=1:noOfSpins
     
        vecMus(k,1)=exp(-t(i+1)./T2).*((vecMus1(k,1).*cos(w(k).*t(i+1)))+(vecMus1(k,2).*sin(w(k).*t(i+1))));
        vecMus(k,2)=exp(-t(i+1)./T2).*((vecMus1(k,2).*cos(w(k).*t(i+1)))-(vecMus1(k,1).*sin(w(k).*t(i+1))));
        vecMus(k,3)=(vecMus1(k,3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));
    
    end
    
    M_trans=(sum(sum(vecMus(:,1:2))))./(mu.*noOfSpins);
    
    h2_2 = plot(h2_1,t_from_start,M_trans,...
        'Color', 'r', 'Marker', '.', 'MarkerSize', 10);
    hold on
    
    h3_2 = plot_Q5_p1_trans_plane(stage, h3_1, vecMu, vecMus);
    hold on
    
    h3 = plot_Q5_p1_spins(stage, h1, vecMu, vecMus);
    hold on
    
%     VideoAddFrame(video, h);
    pause(0.05);
    
    ClearLinesFromAxes(h3_2);
    ClearLinesFromAxes(h3);
    
end
plot_Q5_p1_spins(stage, h1, vecMu, vecMus);
plot_Q5_p1_trans_plane(stage, h3_1, vecMu, vecMus);
% video.close();
     
     
     
     
     