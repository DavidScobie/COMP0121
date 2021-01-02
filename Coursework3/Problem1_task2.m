clear all
close all
delta_k=zeros(1,128);
delta_k(65)=1;
x=linspace(-0.004,0.004-(2.*(0.004./128)),128);
k=linspace(-8000,8000-125,128);
y=ifftshift(ifft(fftshift(delta_k)));
figure;
subplot(2,1,1)
plot(x,real(y))
hold on
plot(x,imag(y))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
subplot(2,1,2)
plot(k,delta_k)
ylabel('\rho(k)')
xlabel('k(1/m)')