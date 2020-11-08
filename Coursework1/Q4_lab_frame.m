clear all
close all
%Question 4
%Free induction decay

%B1 precession into transverse plane in laboratory frame

theta=linspace(0,pi./2,200);
phi=linspace(13.*pi./2,pi./2,200);
mu=0.5;

vecMu_up=[0,0,0];

noOfSteps = 200;

B1=mu.*0.1.*[1 0 0];

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

B0=[0 0 mu];
plot3([0 B0(1)], [0 B0(2)],...
     [0 B0(3)], 'Linestyle', '-', 'LineWidth', 2);
hold on
% plot3([0 B1(1)], [0 B1(2)],...
%      [0 B1(3)], 'Linestyle', '-', 'LineWidth', 2);
%  hold on

 B1phi=linspace(6.*pi,0,200);
 
for i=1:200
    
    vecMu(1)=mu.*[cos(phi(i)).*sin(theta(i))];
    vecMu(2)=mu.*[sin(phi(i)).*sin(theta(i))];
    vecMu(3)=mu.*cos(theta(i));
    
    B1(1)=mu.*0.1.*cos(B1phi(i));
    B1(2)=mu.*0.1.*sin(B1phi(i));
    
    hnew = plotSpin3_line_only(i,h1, vecMu ,B1, vecMu_up);
    
    hold on
    pause(0.01)
    
    ClearLinesFromAxes(hnew)
end
plotSpin3_line_only(i,h1, vecMu ,B1,vecMu_up);

%%

theta=pi./2;
phi=pi./2;

%vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
vecMu0=vecMu;

noOfSteps = 1000;
w0=(2./3).*pi;
w=w0;

T1=10;
T2=5;
t=linspace(0,3.*T1,noOfSteps);

B1=[0,0,0];
vecMu=[0 0 0];
l=0;

for i=0:noOfSteps-1
   
    vecMu_up(1)=exp(-t(i+1)./T2).*((vecMu0(1).*cos(w.*t(i+1)))+(vecMu0(2).*sin(w.*t(i+1))));
    vecMu_up(2)=exp(-t(i+1)./T2).*((vecMu0(2).*cos(w.*t(i+1)))-(vecMu0(1).*sin(w.*t(i+1))));
    vecMu_up(3)=(vecMu0(3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1)); 
    
    h_up = plotSpin3_line_only(l,h1,vecMu,B1,vecMu_up);
    
    hold on
    
    pause(0.001);
    
    ClearLinesFromAxes(h_up);

end
disp('done plot 1')