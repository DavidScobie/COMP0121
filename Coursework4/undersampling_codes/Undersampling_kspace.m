close all;
clc;
clear;

addpath('../gridder')

matrix_size= 256;
% this is a standard shepp-logan phantom often used in MRI 
P = phantom('Modified Shepp-Logan',matrix_size);
figure; imagesc(P); axis('square'); colormap('gray'); title('Shepp-Logan phantom')