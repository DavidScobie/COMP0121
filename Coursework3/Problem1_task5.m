clear all 
close all

h=figure;
set(h, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%Defining the gaussian function G(k)
k=linspace(-8000,8000-125,128);
for i = 1:128
    Gk = exp(-(k.^2)./(2.*(1000.^2)));
end
subplot(3,2,1:2)
plot(k,Gk)
xlabel('k')
ylabel('G(k)')

%brute force
x=linspace(-0.004,0.004-(2.*(0.004./128)),128);
signal=ifftshift(ifft(fftshift(Gk)));
subplot(3,2,3)
plot(x,real(signal))
hold on
plot(x,imag(signal))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('signal (brute force)')

%linearity of FT
