%First the B1 flip
clear all
close all
set(0,'DefaultLegendAutoUpdate','off')

mu=0.5;
theta=0;
phi=pi./2;

N=200;
GMax=4.6;
Ts=4;
noOfSteps = 16;
L=20;
spin_spacing=1;
% no_of_spins = 23;

% vecMus0=zeros(3,no_of_spins);
% vecMus0orig=zeros(3,no_of_spins);

%The initial spin vector magnitudes

%Uniform square distribution
vecMus0=[-11,-6,-1,-11,-6,-1,-11,-6,-1,1,6,11,1,6,11,1,6,11;-11,-11,-11,-6,-6,-6,-1,-1,-1,1,1,1,6,6,6,11,11,11;0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];

%Uniform square with a few rogue spins
%vecMus0=[-4,-2,6,1,7,-3,-10,-5,0,-10,-5,0,-10,-5,0,5,10,0,5,10,0,5,10;-7,-1,9,5,4,-2,-10,-10,-10,-5,-5,-5,0,0,0,0,0,5,5,5,10,10,10;0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];

%Totally random spins everywhere
%vecMus0=[-9,-1.7,-3.8,-8.6,-9.1,-4.8,-4.1,-5.8,-6.0,0,4.7,1.8,8.6,7.1,2.8,9.1,5.8,6.0;-1,-5.2,-1.1,-6.0,-5.7,-5.3,-0.9,-6.9,-8.2,0,5.2,4.1,3.0,2.7,5.3,1.9,8.9,7.2;0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];
vecMusReset=vecMus0;

siz=size(vecMus0);
no_of_spins = siz(2);

%The initial spin vector origins
vecMus0orig(1:2,:)=vecMus0(1:2,:);
vecMus0orig(3,:)=zeros(1,no_of_spins);

h = figure;
set(h, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
h1=subplot(1,1,1);
hold on;
axis equal;
view(100, 10);
xlabel('x');
ylabel('y');
zlabel('z');
xlim([-12 12]);
ylim([-12 12]);
zlim([0 0.5]);
grid on;

stage=1;
t=0;

for i=0:noOfSteps-1
    
    t=(i+1).*0.02;
    
    theta=pi./32;

    
    %calculate the vectors of each spin
    for k = 1:no_of_spins
        
        %Moving initial vector to near origin
        vecMusInit(1,k)=vecMusReset(1,k)-vecMus0orig(1,k);
        vecMusInit(2,k)=vecMusReset(2,k)-vecMus0orig(2,k);
        vecMusInit(3,k)=vecMusReset(3,k)-vecMus0orig(3,k);;
        
        %x rotation
        [vecMusRot(1,k),vecMusRot(2,k),vecMusRot(3,k)]=x_rotation(vecMusInit(1,k),vecMusInit(2,k),vecMusInit(3,k),theta);
        
        %Resetting position to actual
        vecMusReset(1,k)=vecMusRot(1,k)+vecMus0orig(1,k);
        vecMusReset(2,k)=vecMusRot(2,k)+vecMus0orig(2,k); 
        vecMusReset(3,k)=vecMusRot(3,k)+vecMus0orig(3,k); 
    end
    
    %Plot the spin vectors
    hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t,h1,vecMus0orig,vecMusReset);
    
       
    pause(0.1);
    
    ClearLinesFromAxes(h1);

end
plotSpin3D_2Dgrid(stage,no_of_spins,t,h1,vecMus0orig,vecMusReset);

%%
%Gy is on for Ts/2, this is the phase encoding gradient

%Redefine the axes to 2D now
delete(h1)
h1=subplot(2,2,1);
hold on;
axis equal;
xlabel('x');
ylabel('y');
xlim([-12 12]);
ylim([-12 12]);
grid on;

h2 = subplot(2,2,2);
hold on;
xlabel('time (ms)');
ylabel('M_x,M_y');
xlim(h2,[0 (2.*Ts)+0.32])
ylim([-1 1]);
grid on; 

set(0,'DefaultLegendAutoUpdate','off')

vecMus2start=vecMusReset(1:2,:);
T2=10;

stage=2;
Gy=4.6./7;

wy=zeros(no_of_spins);
for i = 1:no_of_spins
    wy(i)=Gy.*0.3.*(vecMus0orig(2,i));
end    


for i = 1:N./2
    
    t_from_start=0.32+(i.*(Ts./(N)));
    t=(i.*(Ts./(N)));
    ky1=0.1.*Gy.*t;
    
    for k = 1:no_of_spins
        %Moving initial vector to near origin
        vecMus2init(1,k)=vecMus2start(1,k)-vecMus0orig(1,k);
        vecMus2init(2,k)=vecMus2start(2,k)-vecMus0orig(2,k);
        
        %Bloch equations
        vecMus2rot(1,k)=exp((-t)./T2).*((vecMus2init(1,k).*cos(wy(k).*t))+((vecMus2init(2,k).*(sin(wy(k).*t)))));
        vecMus2rot(2,k)=exp((-t)./T2).*((vecMus2init(2,k).*cos(wy(k).*t))-((vecMus2init(1,k).*(sin(wy(k).*t)))));
        
        %Resetting position to actual
        vecMus2reset(1,k)=vecMus2rot(1,k)+vecMus0orig(1,k);
        vecMus2reset(2,k)=vecMus2rot(2,k)+vecMus0orig(2,k);       
    end
    
    hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus2reset);
    legend(h1,'hide')
    
    %Calculating transverse magnetisation
    for i = 1:no_of_spins    
        Mx(i)=vecMus2reset(1,i)-vecMus0orig(1,i);
        My(i)=vecMus2reset(2,i)-vecMus0orig(2,i);
    end
    Mxtot=sum(Mx./(no_of_spins.*mu));
    Mytot=sum(My./(no_of_spins.*mu));
    
    hMTrans = plot_Task1_MTrans(t_from_start,h2,Mxtot,Mytot);
    
    pause(0.001);
    
    ClearLinesFromAxes(h1);
end
plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus2reset);

%%
%Gx is on for Ts/2, this is the dephasing lobe of the readout gradient 

vecMus3start=vecMus2reset;
Gx=-4.6;
T2=10;

wx=zeros(no_of_spins);
for i = 1:no_of_spins
    wx(i)=Gx.*0.3.*(vecMus0orig(1,i));
end 

for i = 1:N./2
    
    t_from_start=(0.32)+(Ts./2)+(i.*(Ts./(N)));
    t=(i.*(Ts./(N)));
%     kx1=0.1.*Gx.*t;
    
    for k = 1:no_of_spins
        %Moving initial vector to near origin
        vecMus3init(1,k)=vecMus3start(1,k)-vecMus0orig(1,k);
        vecMus3init(2,k)=vecMus3start(2,k)-vecMus0orig(2,k);
        
        %Bloch equations
        vecMus3rot(1,k)=exp((-t)./T2).*((vecMus3init(1,k).*cos(wx(k).*t))+((vecMus3init(2,k).*(sin(wx(k).*t)))));
        vecMus3rot(2,k)=exp((-t)./T2).*((vecMus3init(2,k).*cos(wx(k).*t))-((vecMus3init(1,k).*(sin(wx(k).*t)))));
        
        %Resetting position to actual
        vecMus3reset(1,k)=vecMus3rot(1,k)+vecMus0orig(1,k);
        vecMus3reset(2,k)=vecMus3rot(2,k)+vecMus0orig(2,k);       
    end
    
    hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus3reset);
    legend(h1,'hide')
    
        %Calculating transverse magnetisation
    for i = 1:no_of_spins    
        Mx(i)=vecMus3reset(1,i)-vecMus0orig(1,i);
        My(i)=vecMus3reset(2,i)-vecMus0orig(2,i);
    end
    Mxtot=sum(Mx./(no_of_spins.*mu));
    Mytot=sum(My./(no_of_spins.*mu));
    
    hMTrans = plot_Task1_MTrans(t_from_start,h2,Mxtot,Mytot);
    
    pause(0.01);
    
    ClearLinesFromAxes(h1);
end
plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus3reset);

%%
%-Gx is on for Ts, this is the rephasing lobe of the readout gradient 

vecMus3start=vecMus2reset;
Gx=4.6;
T2=10;

wx=zeros(no_of_spins);
for i = 1:no_of_spins
    wx(i)=Gx.*0.3.*(vecMus0orig(1,i));
end 

for i = 1:N
    
    t_from_start=(0.32)+(Ts./2)+(Ts./2)+(i.*(Ts./N));
    t=(i.*(Ts./N));
    kx1=0.1.*Gx.*t;
    
    for k = 1:no_of_spins
        %Moving initial vector to near origin
        vecMus3init(1,k)=vecMus3start(1,k)-vecMus0orig(1,k);
        vecMus3init(2,k)=vecMus3start(2,k)-vecMus0orig(2,k);
        
        %Bloch equations
        vecMus3rot(1,k)=exp((-t)./T2).*((vecMus3init(1,k).*cos(wx(k).*t))+((vecMus3init(2,k).*(sin(wx(k).*t)))));
        vecMus3rot(2,k)=exp((-t)./T2).*((vecMus3init(2,k).*cos(wx(k).*t))-((vecMus3init(1,k).*(sin(wx(k).*t)))));
        
        %Resetting position to actual
        vecMus3reset(1,k)=vecMus3rot(1,k)+vecMus0orig(1,k);
        vecMus3reset(2,k)=vecMus3rot(2,k)+vecMus0orig(2,k);       
    end
    
    hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus3reset);
    legend(h1,'hide')
    
        %Calculating transverse magnetisation
    for i = 1:no_of_spins    
        Mx(i)=vecMus3reset(1,i)-vecMus0orig(1,i);
        My(i)=vecMus3reset(2,i)-vecMus0orig(2,i);
    end
    Mxtot=sum(Mx./(no_of_spins.*mu));
    Mytot=sum(My./(no_of_spins.*mu));
    
    hMTrans = plot_Task1_MTrans(t_from_start,h2,Mxtot,Mytot);
    
    pause(0.01);
    
    ClearLinesFromAxes(h1);
end
plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus3reset);














% %Creating the cauchy dist and making weightings accordingly
% no_of_spins=17;
% wmax=pi;
% w=linspace(-wmax,wmax,no_of_spins);
% middle=0;
% delta=pi./2;
% weightings = cauchy(w,middle,delta);
% sumweights=sum(weightings);
% norm_factor=no_of_spins./sumweights;
% weightings=weightings.*norm_factor;
% plot(weightings)
% 
% %%
% clear all
% close all
% 
% pd = makedist('tLocationScale','mu',3,'sigma',1,'nu',1);
% x = -20:1:20;
% y = pdf(pd,x);
% plot(x,y,'LineWidth',2)
% rng('default');  % For reproducibility
% r = random(pd,10,1)
% hold on
% plot(r)
% 
% figure
% pd = makedist('tLocationScale','mu',-3,'sigma',1,'nu',1);
% x = -20:1:20;
% y = pdf(pd,x);
% plot(x,y,'LineWidth',2)
% rng('default');  % For reproducibility
% r = random(pd,10,1)
% hold on
% plot(r)

%%

