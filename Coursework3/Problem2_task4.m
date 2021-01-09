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

subplot(3,3,1)
imagesc(xlims,ylims,brain)
axis image
axis xy
xlabel('x/m')
ylabel('y/m')
colormap('gray');
title('a) Original image')

%fft of the image
kx_lims=[-500 500-3.90625];
ky_lims=[-500 500-3.90625];

f=(fftshift(fft2(brain)));

subplot(3,3,2)
image(kx_lims,ky_lims,abs(f))
axis image
xlabel('kx/(1/m)')
ylabel('ky/(1/m)')
colormap('gray');
title('b) fourier transform')
axis xy

rect_L_edge=113;
rect_R_edge=145;

%high pass filter
rect=ones(256);
rect(rect_L_edge:rect_R_edge,rect_L_edge:rect_R_edge)=0;
subplot(3,3,3)
imagesc(kx_lims,ky_lims,rect)
axis image
xlabel('kx/(1/m)')
ylabel('ky/(1/m)')
colormap('gray');
title('c) rect filter')
axis xy

%PSF
PSF=ifftshift(ifft2(fftshift(rect)));
subplot(3,3,4)
imagesc(xlims, ylims, PSF);
axis image
xlabel('x/m')
ylabel('y/m')
colormap('gray');
title('d) IFT of rect filter (PSF)')
axis xy

%filtered fft way
lpf=zeros(256);
lpf=rect.*f;
subplot(3,3,5)
image(kx_lims,ky_lims,abs(lpf))
axis image
xlabel('kx/(1/m)')
ylabel('ky/(1/m)')
colormap('gray');
title('e) filtered fourier transform')
axis xy

fil_img=(ifft2(ifftshift(lpf)));
subplot(3,3,6)
imagesc(xlims,ylims,abs(fil_img))
axis image
xlabel('x/m')
ylabel('y/m')
colormap('gray');
title('f) IFT of filtered FT')
axis xy

%convolution of PSF and original brain
convy=conv2(PSF,brain);
res_convy=convy(128:383,128:383);
subplot(3,3,7)
imagesc(xlims,ylims,res_convy)
axis image
xlabel('x/m')
ylabel('y/m')
colormap('gray');
title('g) convolution of PSF with original image')
axis xy