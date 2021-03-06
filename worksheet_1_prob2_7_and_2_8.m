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

h3 = subplot(2,2,4);
hold on;
xlabel('time (ms)');
ylabel('\mu_y');
xlim([0, noOfSteps*deltaT]);
ylim([-0.5 0.5]);
grid on;