%%
clear all
close all
mu=0.5;
B0=mu.*[0 0 1];
B1=mu.*0.1.*[1 0 0];
Beff=B0+B1;
M=B0;

M=cross(M,Beff);

figure
h1=subplot(1,1,1)
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

quiver3(0, 0, 0, B0(1), B0(2), B0(3), 0, 'b');
hold on
% quiver3(0, 0, 0, B1(1), B1(2), B1(3), 0, 'r'); 
% hold on
quiver3(0, 0, 0, Beff(1), Beff(2), Beff(3), 0, 'g'); 
hold on
quiver3(0, 0, 0, M(1), M(2), M(3), 0, 'r'); 

%%

figure;
h1=subplot(1,1,1)
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

theta=linspace(0,pi./2,200);
phi=linspace(0,6.*pi,200);
mu=0.5;
Mx=zeros(1,200);
My=zeros(1,200);
Mz=zeros(1,200);
for i=1:200
    Mx(i)=mu.*[cos(phi(i)).*sin(theta(i))];
    My(i)=mu.*[sin(phi(i)).*sin(theta(i))];
    Mz(i)=mu.*cos(theta(i));
    plot3(Mx,My,Mz);
    hold on
end
    