%Q5 part 1
clear all 
close all

%Initial pi./2 pulse flip to y' plane
mu=0.5;
theta=0;
phi=pi./2;
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';
noOfSteps = 200;

figure;
h1=subplot(1,1,1);
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

stage=1;
for i=0:noOfSteps-1
    
    theta=pi./(noOfSteps.*2);
    [vecMu(1),vecMu(2),vecMu(3)]=x_rotation(vecMu(1),vecMu(2),vecMu(3),theta);
    
    h2 = plot_Q5_p1(stage, h1, vecMu);
    hold on
    
    pause(0.003);
    
    ClearLinesFromAxes(h2)
    
end

%%
%T1 relaxation up z slightly and spin dephasing

noOfSpins=10;
vecMus=zeros(noOfSpins,3);
vecMuSize=size(vecMus);

for i=1:vecMuSize(1)
     vecMus(i,:)=vecMu;
end
 
T1=10;
T2=5;
noOfSteps=100;
t=linspace(0,T1./6,noOfSteps);
vecMus0=vecMus;
wmax=pi./6;
w=linspace(-wmax,wmax,noOfSpins);

stage=2;
for i=0:noOfSteps-1
    
    for k=1:noOfSpins
     
        vecMus(k,1)=exp(-t(i+1)./T2).*((vecMus0(k,1).*cos(w(k).*t(i+1)))+(vecMus0(k,2).*sin(w(k).*t(i+1))));
        vecMus(k,2)=exp(-t(i+1)./T2).*((vecMus0(k,2).*cos(w(k).*t(i+1)))-(vecMus0(k,1).*sin(w(k).*t(i+1))));
        vecMus(k,3)=(vecMus0(k,3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));
    
    end
    
    h3 = plot_Q5_p1(stage, h1, vecMu, vecMus);
    
    hold on
    
    pause(0.0005);
    
    ClearLinesFromAxes(h3);
    
end

%%
%pi pulse along y' causes flip around y' axis
noOfSteps=100;
theta=pi./(noOfSteps);

for i=0:noOfSteps-1
    
    for k=1:noOfSpins
        [vecMus(k,1),vecMus(k,2),vecMus(k,3)]=y_rotation(vecMus(k,1),vecMus(k,2),vecMus(k,3),theta);
    end
    
    h3 = plot_Q5_p1(stage, h1, vecMu, vecMus);
    
    hold on
    
    pause(0.0002);
    
    ClearLinesFromAxes(h3);
    
end
      
%%
% Relaxation causing echo along y' axis
noOfSteps=200;
vecMus1=vecMus;
t=linspace(0,3.*T1,noOfSteps);

for i=0:noOfSteps-1
    
    for k=1:noOfSpins
     
        vecMus(k,1)=exp(-t(i+1)./T2).*((vecMus1(k,1).*cos(w(k).*t(i+1)))+(vecMus1(k,2).*sin(w(k).*t(i+1))));
        vecMus(k,2)=exp(-t(i+1)./T2).*((vecMus1(k,2).*cos(w(k).*t(i+1)))-(vecMus1(k,1).*sin(w(k).*t(i+1))));
        vecMus(k,3)=(vecMus1(k,3).*(exp(-t(i+1)./T1)))+mu.*(1-exp(-t(i+1)./T1));
    
    end
    
    h3 = plot_Q5_p1(stage, h1, vecMu, vecMus);
    
    hold on
    
    pause(0.05);
    
    ClearLinesFromAxes(h3);
    
end
plot_Q5_p1(stage, h1, vecMu, vecMus);
  
     
     
     
     
     