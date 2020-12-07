function [mu_x,mu_y,mu_z] = z_rotation_1Dline(xorig,mu_x0,mu_y0,mu_z0,phi)
%Defining initial vector and rotation matrix
mu_0=[mu_x0;mu_y0;mu_z0];
rot_z = [cos(phi),sin(phi),0;-sin(phi),cos(phi),0;0,0,1];


mu_1=[mu_x0-xorig;mu_y0;mu_z0];
mu_t=rot_z*mu_1;

mu_x=xorig+mu_t(1);
mu_y=mu_t(2);
mu_z=mu_t(3);


end

