function [mu_x,mu_y,mu_z] = T1_relax(mu_x0,mu_y0,mu_z0,phi,theta,mu,times,T1)
%ROTATION Summary of this function goes here
%   Detailed explanation goes here
mu_0=[mu_x0;mu_y0;mu_z0];
z_rot = [cos(phi),sin(phi),0;-sin(phi)...
    ,cos(phi),0;0,0,1];
mu_t=z_rot*mu_0;
%mu_x=mu_t(1).*sin(theta);
%mu_y=mu_t(2).*sin(theta);
mu_x=mu_t(1).*exp(-times./T1);
mu_y=mu_t(2).*exp(-times./T1);
mu_z=mu.*cos(theta);
end

