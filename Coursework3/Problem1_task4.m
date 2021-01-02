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

k0=-2500;
index=(k0./125)+65;

%Brute force
delta_k=zeros(1,128);
Gk_del=zeros(1,128);
delta_k(index)=1;
Gk_del(index)=Gk(index).*delta_k(index);
x=linspace(-0.004,0.004-(2.*(0.004./128)),128);
brute_sig=ifftshift(ifft(fftshift(Gk_del)));
subplot(3,2,3)
plot(x,real(brute_sig))
hold on
plot(x,imag(brute_sig))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('signal (brute force)')
subplot(3,2,4)
plot(k,Gk_del)
ylabel('\delta(k)')
xlabel('k(1/m)')
title('G(k)*\delta(k-k0) (brute force)')

%Linearity of fourier transform idea
delta_k1=zeros(1,128);
delta_k1(index)=1;
linearity_sig=ifftshift(ifft(fftshift(delta_k1)));
for i = 1:128
    linearity_sig(i)=Gk(index).*linearity_sig(i);
end
subplot(3,2,5)
plot(x,real(linearity_sig))
hold on
plot(x,imag(linearity_sig))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('signal (linearity of FT)')
subplot(3,2,6)
plot(k,delta_k1)
ylabel('\delta(k)')
xlabel('k(1/m)')
title('\delta(k-k0) (linearity of FT)')





% %Defining delta(k-k0)
% delta_k=zeros(1,128);
% delta_k(65:65)=1;
% 
% %Defining G(k)delta(k-k0)
% G_k_delta=zeros(1,128);
% for i = 1:128
%     G_k_delta(i)=Gk(i).*delta_k(i);
% end
% 
% %Defining G(k0)
% %2D because G(k0) is the gaussian graph centred at each of the 128 values
% %of k.
% Gk0=zeros(128);
% for i = 1:128
%     k0(i)=k(i);
%     for p = 1:128
%         Gk0(i,p) = exp((-(k(p)-k0(i)).^2)./(2.*(1000.^2)));
%     end
% end
% 
% %Defining G(k0)delta(k-k0)  
% %The value of g(k0) is the peak for each value of k0
% G_k0_delta=zeros(1,128);
% for i = 1:128
%     G_k0_delta(i)=Gk0(i,i).*delta_k(i);
% end