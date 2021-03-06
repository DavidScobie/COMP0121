%DEFINE THE INITIAL SPIN VECTOR
% magnitude in the unit of gamma*h_bar
mu = 1/2;
% set the initial direction in terms of polar and azimuthal angles
% polar angle
theta = pi/6;
% azimuthal angle
phi = 0;
% compute the Cartesian components of the vector
vecMu = mu*[cos(phi)*sin(theta) sin(phi)*sin(theta) cos(theta)]';

%VISUALISE THE PRECESSION IN THE ROTATING FRAME OF THE LAMOR FREQUENCY
% set the precession frequency relative to the Larmor frequency
% in the unit of radian*kHz
omega = 2*pi;
% set the time increment (in the unit of ms)
deltaT = 0.01;
% set the number of time increments to animate
noOfSteps = 200;

%CREATE THE SUBPLOTS FOR PLOTTING
figure;
h1 = subplot(2,2,1);
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

h2 = subplot(2,2,2);
hold on;
xlabel('\mu_x');
ylabel('\mu_y');
xlim([-0.5 0.5]);
ylim([-0.5 0.5]);
grid on;
axis square

h3 = subplot(2,2,3);
hold on;
xlabel('time (ms)');
ylabel('\mu_x');
xlim([0, noOfSteps*deltaT]);
ylim([-0.5 0.5]);
grid on;

h4 = subplot(2,2,4);
hold on;
xlabel('time (ms)');
ylabel('\mu_y');
xlim([0, noOfSteps*deltaT]);
ylim([-0.5 0.5]);
grid on;  

%Create the rotation matrix
rot = [cos(phi),sin(phi),0;-sin(phi),cos(phi),0;0,0,1];

%Looping over  the 200 time increments
for i=0:noOfSteps-1

    %Updating vecMu
    phi=(pi./100);  
    rot = [cos(phi),sin(phi),0;-sin(phi),cos(phi),0;0,0,1];
    vecMu = rot * vecMu;

    %Updating deltaT
    deltaT=i./100;
    
    
    % function plotSpin3D showing 3D spin precession. 
    hVecMu = plotSpin3D(h1, vecMu);
    % function hTransverseMu showing the precession in the x,y plane.
    hTransverseMu = plotSpinTransverse(h2,vecMu);
    % function plotSpinh_mux_t showing the precession of mux with time.
    h_mux_t = plotSpinh_mux_t(h3,vecMu,deltaT);
    % function plotSpinh_muy_t showing the precession of muy with time.
    h_muy_t = plotSpinh_muy_t(h4,vecMu,deltaT);
    
    pause(0.05);
    %Deleting all of the plots after a pause.
    delete(hVecMu);
    
    delete(hTransverseMu);
    
    delete(h_mux_t);
    
    delete(h_muy_t);
    %Plotting the precessions again.
    plotSpin3D(h1, vecMu);
    
    plotSpinTransverse(h2,vecMu);
    
    plotSpinh_mux_t(h3,vecMu,deltaT);
    
    plotSpinh_muy_t(h4,vecMu,deltaT);

end




%     %time variance of theta
%     theta=theta+((2.*pi.*t)./200);
% 
%     %time variation of mux, muy and muz
%     mux0=1;
%     muy0=1;
%     muz0=1;
%     muxt=(mux0.*cos(theta))+(muy0.*sin(theta));
%     muyt=(-mux0.*sin(theta))+(muy0.*cos(theta));
%     muzt=muz0;