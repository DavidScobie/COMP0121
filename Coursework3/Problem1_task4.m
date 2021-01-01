clear all 
close all
%Defining the gaussian function G(k)
k=linspace(-8000,8000-125,128);
for i = 1:128
    Gk = exp(-(k.^2)./(2.*(1000.^2)));
end
figure
plot(k,Gk)
xlabel('k')
ylabel('G')

%Defining delta(k-k0)
delta_k=zeros(1,128);
delta_k(65:65)=1;

%Defining G(k)delta(k-k0)
G_k_delta=zeros(1,128);
for i = 1:128
    G_k_delta(i)=Gk(i).*delta_k(i);
end

%Defining G(k0)
%2D because G(k0) is the gaussian graph centred at each of the 128 values
%of k.
Gk0=zeros(128);
for i = 1:128
    k0(i)=k(i);
    for p = 1:128
        Gk0(i,p) = exp((-(k(p)-k0(i)).^2)./(2.*(1000.^2)));
    end
end

%Defining G(k0)delta(k-k0)  
%The value of g(k0) is the peak for each value of k0
G_k0_delta=zeros(1,128);
for i = 1:128
    G_k0_delta(i)=Gk0(i,i).*delta_k(i);
end