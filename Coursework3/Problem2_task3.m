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

subplot(2,3,1)
imagesc(xlims,ylims,brain)
axis image
axis xy
xlabel('x/m')
ylabel('y/m')
colormap('gray');

%fft of the image
kx_lims=[-500 500-3.90625];
ky_lims=[-500 500-3.90625];

f=(fftshift(fft2(brain)));

subplot(2,3,2)
image(kx_lims,ky_lims,abs(f))
axis image
xlabel('kx/(1/m)')
ylabel('ky/(1/m)')
colormap('gray');
title('fourier transform')
axis xy

% subplot(2,3,3)
% g=abs(ifft2(ifftshift(abs(f))));
% imshow(g)


% subplot(2,3,4)
% h=(fft2(brain));
% % image(h)
% subplot(2,3,5)
% j=ifft2(h);
% imagesc(j)


rect_L_edge=113;
rect_R_edge=145;
%low pass filter
rect=zeros(256);
rect(rect_L_edge:rect_R_edge,rect_L_edge:rect_R_edge)=1;
subplot(2,3,4)
imagesc(kx_lims,ky_lims,rect)
axis image
xlabel('kx/(1/m)')
ylabel('ky/(1/m)')
colormap('gray');
title('rect filter')
axis xy

%filtered fft way
lpf=zeros(256);
lpf(rect_L_edge:rect_R_edge,rect_L_edge:rect_R_edge)=rect(rect_L_edge:rect_R_edge,rect_L_edge:rect_R_edge).*((f(rect_L_edge:rect_R_edge,rect_L_edge:rect_R_edge)));
subplot(2,3,5)
image(kx_lims,ky_lims,abs(lpf))
axis image
xlabel('kx/(1/m)')
ylabel('ky/(1/m)')
colormap('gray');
title('filtered fourier transform')
axis xy


fil_img=(ifft2(ifftshift(lpf)));
subplot(2,3,6)
imagesc(xlims,ylims,abs(fil_img))
axis image
xlabel('x/m')
ylabel('y/m')
colormap('gray');
title('filtered fourier transform')
axis xy

