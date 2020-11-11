function [mu_x,mu_y,mu_z] = z_rotation(mu_x0,mu_y0,mu_z0,phi)
%ROTATION Summary of this function goes here
%   Detailed explanation goes here
mu_0=[mu_x0;mu_y0;mu_z0];
rot_z = [cos(phi),sin(phi),0;-sin(phi),cos(phi),0;0,0,1];
mu_t=rot_z*mu_0;
mu_x=mu_t(1);
mu_y=mu_t(2);
mu_z=mu_t(3);
end

