clear all 
close all

h=figure;
set(h, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%Define rect filter
rect=zeros(1,128);
rect(57:73)=1;
k=linspace(-8000,8000-125,128);
subplot(4,2,1)
plot(k,rect);
xlabel('k(1/m)')
ylabel('rect(k)')
title('rectangle filter')

%Define gaussian function
Gk = exp(-(k.^2)./(2.*(1000.^2)));
subplot(4,2,2)
plot(k,Gk)
xlabel('k(1/m)')
ylabel('G(k)')
title('Gaussian function')

%% PSF way
%IFT of rect filter
x=linspace(-0.004,0.004-(2.*(0.004./128)),128);
signal_r=ifftshift(ifft(fftshift(rect)));
subplot(4,2,3)
plot(x,signal_r)
xlabel('x/m')
ylabel('signal')
title('IFT of rect filter (PSF)')

%IFT of gaussian function
signal_g=ifftshift(ifft(fftshift(Gk)));
subplot(4,2,4)
plot(x,real(signal_g))
hold on
plot(x,imag(signal_g))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('IFT of gaussian function')

%Convolution of IFT of rect filter and IFT of gaussian function
conv_signal=conv(signal_r,signal_g);
trunc_conv_signal=conv_signal(65:192);
subplot(4,2,6)
plot(x,trunc_conv_signal);
title('Convolution of PSF and IFT(G(k))')
xlabel('x/m')
ylabel('signal')

%% Filtered G(k) way

filt_Gk=zeros(1,128);
for i = 1:128
    filt_Gk(i)=Gk(i).*rect(i);
end

subplot(4,2,7)
plot(k,filt_Gk);
xlabel('k(1/m)')
ylabel('G(k)*rect(k)')
title('G(k) with filter applied')

signal_filt=ifftshift(ifft(fftshift(filt_Gk)));
subplot(4,2,8)
plot(x,signal_filt);
xlabel('x/m')
ylabel('signal')
title('IFT of filtered G(k)')