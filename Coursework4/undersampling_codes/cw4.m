clear all 
close all

addpath('../gridder')

matrix_size= 192;
% shepp logan phantom
P = phantom('Modified Shepp-Logan',matrix_size);
figure; imagesc(P); axis('square'); colormap('gray'); title('Shepp-Logan phantom')

%fourier transform
FTP=fft2(P);
figure;
image(abs(real(fftshift(FTP))))
title('Fourier transform of shepp logan phantom')

%grid onto a radial trajectory
