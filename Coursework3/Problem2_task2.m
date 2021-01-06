clear all
close all

h=figure;
set(h, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

load('data.mat');
brain=rot90(brain);

coords=zeros(2,256.^2);
for i = 1:(256.^2)
    coords(1,i)=((floor((i-1)./256))-128).*10.^-3;
end
coords(2,:)=repmat(linspace(-0.128,0.127,256),1,256);

xlims=[coords(1,1) coords(1,65536)];
ylims=[0.128 -0.128];

subplot(2,3,1:3)
imagesc(xlims,ylims,brain)
axis image
axis xy
xlabel('x/m')
ylabel('y/m')
colormap('gray');

%fft of the image
kx_lims=[-500 500-3.90625];
ky_lims=[-500 500-3.90625];

f=fft2(brain);
subplot(2,3,4)
image(kx_lims,ky_lims,abs(real(fftshift(f))))
axis image
xlabel('kx/(1/m)')
ylabel('ky/(1/m)')
colormap('gray');
title('real part of fourier transform')
axis xy

subplot(2,3,5)
image(kx_lims,ky_lims,abs(imag(fftshift(f))))
axis image
xlabel('kx/(1/m)')
ylabel('ky/(1/m)')
colormap('gray');
title('imaginary part of fourier transform')
axis xy

subplot(2,3,6)
image(kx_lims,ky_lims,abs(fftshift(f)))
axis image
xlabel('kx/(1/m)')
ylabel('ky/(1/m)')
colormap('gray');
title('fourier transform')
axis xy