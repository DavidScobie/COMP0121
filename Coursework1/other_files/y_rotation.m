function [mu_x,mu_y,mu_z] = y_rotation(mu_x0,mu_y0,mu_z0,theta)
%ROTATION Summary of this function goes here
%   Detailed explanation goes here
mu_0=[mu_x0;mu_y0;mu_z0];
rot_y = [cos(theta),0,-sin(theta);0,1,0;sin(theta),0,cos(theta)];
mu_t=rot_y*mu_0;
mu_x=mu_t(1);
mu_y=mu_t(2);
mu_z=mu_t(3);
end
