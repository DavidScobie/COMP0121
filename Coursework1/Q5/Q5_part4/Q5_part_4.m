%%Q5_part_4
clear all
close all

% video = VideoSetup('Q5_part4_vid');
% video.open();

%Initial pi./2 pulse flip to y' plane
mu=0.5;
theta=0;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 200;

T1=10;
T2=5;

h=figure;
h1=subplot(2,2,1);
hold on;
axis equal;
view(100, 10);
xlabel('\mu_x''');
ylabel('\mu_y''');
zlabel('\mu_z');
xlim([-mu.*2 mu.*2]);
ylim([-mu.*2 mu.*2]);
zlim([-mu.*2 mu.*2]);
grid on;

h2_1 = subplot(2,2,3);
hold on;
xlabel('time (ms)');
ylabel('M_{\perp}/M_{\perp}_{max}');
xlim([0, 1+((19./6).*T1)]);
ylim([0 1]);
grid on;

h3_1 = subplot(2,2,4);
hold on;
xlabel('M_x''');
ylabel('M_y''');
xlim([-mu.*2 mu.*2]);
ylim([-mu.*2 mu.*2]);
grid on;

% VideoAddFrame(video, h);

time_from_start=0;
stage=1;
for i=0:noOfSteps-1
    
    time_from_start=((0.5).*(i+1))./noOfSteps;
    
    theta=pi./(noOfSteps.*2);
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    M_trans=sum(vecMu(1:2))./mu;
    
    h2_2 = plot(h2_1,time_from_start,M_trans,...
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
t_end_part_1=time_from_start;
%%

noOfSpins=11;
vecMus=zeros(noOfSpins,3);
vecMuSize=size(vecMus);

for i=1:vecMuSize(1)
     vecMus(i,:)=vecMu;
end

T1=10;
T2=5;
noOfSteps=100;
relax_time1=T1./6;
t=linspace(0,relax_time1,noOfSteps);
vecMus0=vecMus;

%Creating the cauchy dist and making weightings accordingly
wmax=pi;
w=linspace(-wmax,wmax,noOfSpins);
middle=0;
delta=pi./2;
weightings = cauchy(w,middle,delta);
sumweights=sum(weightings);
norm_factor=noOfSpins./sumweights;
weightings=weightings.*norm_factor;

for i=1:length(w)
    for k=1:3
        vecMus0(i,k)=weightings(i).*vecMus(i,k);
    end
end

stage=2;
for i=0:noOfSteps-1
    
    time_from_start=t_end_part_1+((relax_time1).*(i+1))./noOfSteps;
    
    for k=1:noOfSpins
     
        vecMus(k,1)=exp(-t(i+1)./T2).*((vecMus0(k,1).*cos(w(k).*t(i+1)))+(vecMus0(k,2).*sin(w(k).*t(i+1))));
        vecMus(k,2)=exp(-t(i+1)./T2).*((vecMus0(k,2).*cos(w(k).*t(i+1)))-(vecMus0(k,1).*sin(w(k).*t(i+1))));
        vecMus(k,3)=(vecMus0(k,3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));
    
    end
    
    M_trans=(sum(sum(vecMus(:,1:2))))./(mu.*noOfSpins);
    h2_2 = plot(h2_1,time_from_start,M_trans,...
        'Color', 'r', 'Marker', '.', 'MarkerSize', 10);
    hold on
    
    h3_2 = plot_Q5_p1_trans_plane(stage, h3_1, vecMu, vecMus);
    hold on
    
    h3 = plot_Q5_p1_spins(stage, h1, vecMu, vecMus);
    
    hold on
    
%     VideoAddFrame(video, h);
    pause(0.0005);
    
    ClearLinesFromAxes(h3);
    ClearLinesFromAxes(h3_2);
end
t_end_part_2=time_from_start;
%%
%pi/2 pulse along y' causes flip around y' axis
noOfSteps=50;
theta=pi./(noOfSteps.*2);

for i=0:noOfSteps-1
    
    time_from_start=t_end_part_2+((0.5).*(i+1))./noOfSteps;
    
    for k=1:noOfSpins
        [vecMus(k,1),vecMus(k,2),vecMus(k,3)]=x_rotation(vecMus(k,1),vecMus(k,2),vecMus(k,3),theta);
    end
    
    M_trans=(sum(sum(vecMus(:,1:2))))./(mu.*noOfSpins);
    
    h2_2 = plot(h2_1,time_from_start,M_trans,...
        'Color', 'r', 'Marker', '.', 'MarkerSize', 10);
    hold on
    
    h3_2 = plot_Q5_p1_trans_plane(stage, h3_1, vecMu, vecMus);
    hold on
    
    h3 = plot_Q5_p1_spins(stage, h1, vecMu, vecMus);
    
    hold on
%     VideoAddFrame(video, h);
    pause(0.0002);
    
    ClearLinesFromAxes(h3);
    ClearLinesFromAxes(h3_2);
end
t_end_part_3=time_from_start;       
%%
% Relaxation causing echo along y' axis
noOfSteps=200;
vecMus1=vecMus;
relax_time2=3.*T1;
t=linspace(0,relax_time2,noOfSteps);

for i=0:noOfSteps-1
    
    time_from_start=t_end_part_3+((relax_time2).*(i+1))./noOfSteps;
    
    for k=1:noOfSpins
     
        vecMus(k,1)=exp(-t(i+1)./T2).*((vecMus1(k,1).*cos(w(k).*t(i+1)))+(vecMus1(k,2).*sin(w(k).*t(i+1))));
        vecMus(k,2)=exp(-t(i+1)./T2).*((vecMus1(k,2).*cos(w(k).*t(i+1)))-(vecMus1(k,1).*sin(w(k).*t(i+1))));
        vecMus(k,3)=(vecMus1(k,3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));
    
    end
    
    M_trans=(sum(sum(vecMus(:,1:2))))./(mu.*noOfSpins);
    
    h2_2 = plot(h2_1,time_from_start,M_trans,...
        'Color', 'r', 'Marker', '.', 'MarkerSize', 10);
    hold on
    
    h3_2 = plot_Q5_p1_trans_plane(stage, h3_1, vecMu, vecMus);
    hold on
    
    h3 = plot_Q5_p1_spins(stage, h1, vecMu, vecMus);
    
    hold on
%     VideoAddFrame(video, h);
    pause(0.05);
    
    ClearLinesFromAxes(h3);
    ClearLinesFromAxes(h3_2);
end
plot_Q5_p1_spins(stage, h1, vecMu, vecMus);
plot_Q5_p1_trans_plane(stage, h3_1, vecMu, vecMus);
% video.close();