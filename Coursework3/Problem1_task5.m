clear all 
close all

h=figure;
set(h, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%Defining the gaussian function G(k)
k=linspace(-8000,8000-125,128);
for i = 1:128
    Gk = exp(-(k.^2)./(2.*(1000.^2)));
end
subplot(2,2,2)
plot(k,Gk)
xlabel('k(1/m)')
ylabel('G(k)')
title('Gaussian function')

%brute force
x=linspace(-0.004,0.004-(2.*(0.004./128)),128);
signal=ifftshift(ifft(fftshift(Gk)));
subplot(2,2,1)
plot(x,real(signal))
hold on
plot(x,imag(signal))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('signal (brute force)')

%linearity of FT
all_sigs=zeros(128);
for index = 1:128

    delta_k1=zeros(1,128);
    delta_k1(index)=1;
    
    IFT_del=ifftshift(ifft(fftshift(delta_k1)));
    
    for i = 1:128
        linearity_sig(i)=Gk(index).*IFT_del(i);
        all_sigs(index,i)=linearity_sig(i);
    end
    
end

summed_sig=zeros(1,128);
for i = 1:128
    summed_sig(i)=sum(all_sigs(1:128,i));
end

subplot(2,2,3)
plot(x,real(summed_sig))
hold on
plot(x,imag(summed_sig))
legend('real','imaginary')
xlabel('x/m')
ylabel('signal')
title('signal (linearity of FT)')

subplot(2,2,4)


for i = 1:128
    plot([k(i) k(i)],[0 Gk(i)],'b-');
    hold on
end

ylabel('G(k0)*\delta(k-k0)')
xlabel('k(1/m)')
title('Scaled and translated impulse function')
    
    
    
    
    
    
    