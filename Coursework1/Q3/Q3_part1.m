clear all
close all
%% create the video writer object
video = VideoSetup('Q3_part1_vid');
video.open();
%Q3 parts 1 and 2

mu=0.5;
theta=pi./2;
phi=pi./2;

vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
vecMu0=vecMu;

noOfSteps = 500;
w0=(2./3).*pi;
w=w0;

h=figure;
h1=subplot(1,1,1);
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

VideoAddFrame(video, h);

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on

labelPosition=1.05*B0;
label='B0';
text(labelPosition(1),labelPosition(2),labelPosition(3),label);

w=0.05.*2.*pi;
rot_ang=(pi./25).*w;
for i=0:noOfSteps-1
    
    [vecMu(1),vecMu(2),vecMu(3)]=z_rotation(vecMu(1),vecMu(2),vecMu(3),rot_ang);
    
        hVecMu = plot3(h1,[0 vecMu(1)], [0 vecMu(2)],...
     [0 vecMu(3)],'color','r', 'Linestyle', '-', 'LineWidth', 2);
    title(['time=',num2str(i,'%2g'),'ns']);
 
    VideoAddFrame(video, h);
    pause(0.0005);
    
    ClearLinesFromAxes(hVecMu);

end
hVecMu = plot3(h1,[0 vecMu(1)], [0 vecMu(2)],...
    [0 vecMu(3)],'color','r', 'Linestyle', '-', 'LineWidth', 2);
video.close();

    
    