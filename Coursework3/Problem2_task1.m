clear all
close all
load('data.mat');
brain=rot90(brain);

figure;

coords=zeros(2,256.^2);
for i = 1:(256.^2)
    coords(1,i)=((floor((i-1)./256))-128).*10.^-3;
end
coords(2,:)=repmat(linspace(-0.128,0.127,256),1,256);

xlims=[coords(1,1) coords(1,65536)];
ylims=[0.128 -0.128];

imagesc(xlims,ylims,brain)
axis image
axis xy
xlabel('x/m')
ylabel('y/m')
colormap('gray');