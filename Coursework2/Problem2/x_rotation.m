function [mu_x,mu_y,mu_z] = x_rotation(mu_x0,mu_y0,mu_z0,theta)
%ROTATION Summary of this function goes here
%   Detailed explanation goes here
mu_0=[mu_x0;mu_y0;mu_z0];
rot_x = [1,0,0;0,cos(theta),sin(theta);0,-sin(theta),cos(theta)];
mu_t=rot_x*mu_0;
mu_x=mu_t(1);
mu_y=mu_t(2);
mu_z=mu_t(3);
end