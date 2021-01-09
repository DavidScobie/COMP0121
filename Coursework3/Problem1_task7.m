clear all
close all

h=figure;
set(h, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%Define hanning filter
Hanning=zeros(1,128);
k=linspace(-8000,8000-125,128);
W=16.*125;
for i = 1:128
    Hanning(i)=(cos((pi.*k(i))./(W))).^2;
end
Hanning(1:56)=0;
Hanning(74:128)=0;
subplot(4,2,3)
plot(k,Hanning);
title('b) Hanning filter')
xlabel('k(1/m)')
ylabel('H(k)')

%Define gaussian function
Gk = exp(-(k.^2)./(2.*(1000.^2)));
subplot(4,2,1:2)
plot(k,Gk)
xlabel('k(1/m)')
ylabel('G(k)')
title('a) Gaussian function')

%% PSF way

%Define rect filter
rect=zeros(1,128);
rect(57:73)=1;

%Define total filter
tot_filter=zeros(1,128);
for i = 1:128
    tot_filter(i)=Hanning(i).*rect(i);
end

%IFT((H(k)rect(k))
x=linspace(-0.004,0.004-(2.*(0.004./128)),128);
signal_H=ifftshift(ifft(fftshift(tot_filter)));
subplot(4,2,4)
plot(x,signal_H)
xlabel('x/m')
ylabel('signal')
title('c) IFT(H(k)*rect(k))     also called: PSF')

%IFT of gaussian function
signal_g=ifftshift(ifft(fftshift(Gk)));
subplot(4,2,5)
plot(x,real(signal_g))
hold on
plot(x,imag(signal_g))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('d) IFT of gaussian function')

%Convolution of IFT of Hanning filter and IFT of gaussian function
conv_signal=conv(signal_H,signal_g);
trunc_conv_signal=conv_signal(65:192);
subplot(4,2,6)
plot(x,trunc_conv_signal);
title('e) Convolution of PSF and IFT(G(k))')
xlabel('x/m')
ylabel('signal')

%% Filtered G(k) way

filt_Gk=zeros(1,128);
for i = 1:128
    filt_Gk(i)=Gk(i).*rect(i).*Hanning(i);
end

subplot(4,2,7)
plot(k,filt_Gk);
xlabel('k(1/m)')
ylabel('G(k)*rect(k)*H(k)')
title('f) G(k) with filter applied')

signal_filt=ifftshift(ifft(fftshift(filt_Gk)));
subplot(4,2,8)
plot(x,signal_filt);
xlabel('x/m')
ylabel('signal')
title('g) IFT of filtered G(k)')