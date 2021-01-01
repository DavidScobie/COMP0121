clear all
close all

h=figure;
set(h, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%signal and delta function with no shift
delta_k=zeros(1,128);
delta_k(65)=1;
% delta_k(45:85)=1;
x=linspace(-0.004,0.004-(2.*(0.004./128)),128);
k=linspace(-8000,8000-125,128);
signal=ifftshift(ifft(fftshift(delta_k)));
subplot(3,2,1)
plot(x,real(signal))
hold on
plot(x,imag(signal))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('signal no shift')
subplot(3,2,2)
plot(k,delta_k)
ylabel('\delta(k)')
xlabel('k(1/m)')
title('delta function no shift')

%Shift of delta function now
delta_k=zeros(1,128);
delta_k(70)=1;
% delta_k(35:75)=1;
x=linspace(-0.004,0.004-(2.*(0.004./128)),128);
k=linspace(-8000,8000-125,128);
signal2=ifftshift(ifft(fftshift(delta_k)));
subplot(3,2,3)
plot(x,real(signal2))
hold on
plot(x,imag(signal2))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('signal with shift (brute force)')
subplot(3,2,4)
plot(k,delta_k)
ylabel('\delta(k)')
xlabel('k(1/m)')
title('delta function with shift (brute force)')

%Using the shift theorum to compute the shifted signal
shifted_signal=zeros(1,128);
exponential=zeros(1,128);
for q = 1:128
    shifted_signal(q) = signal(q) .* exp(i.*2.*pi.*625.*x(q));
%     exponential(q) = exp(i.*2.*pi.*1250.*x(q));
end
subplot(3,2,5)
plot(x,real(shifted_signal))
hold on
plot(x,imag(shifted_signal))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('signal with shift (shift theorum)')
subplot(3,2,6)
plot(k,delta_k)
ylabel('\delta(k)')
xlabel('k(1/m)')
title('delta function with shift (shift theorum)')

% subplot(3,2,6)
% plot(k,exponential)
% ylabel('\rho(k)')
% xlabel('k(1/m)')
% title('delta function with shift (shift theorum)')


%%Comparing the brute force and shifted k space signals
% figure;
% subplot(2,1,1)
% plot(x,real(signal2))
% hold on
% plot(x,imag(signal2))
% legend('real','imaginary')
% xlabel('x/m')
% ylabel('signal')
% title('signal with shift')
% subplot(2,1,2)
% plot(x,real(shifted_signal))
% hold on
% plot(x,imag(shifted_signal))
% legend('real','imaginary')
% xlabel('x/m')
% ylabel('signal')
% title('signal with shift (shift theorum)')