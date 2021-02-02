clear all 
close all

addpath('../gridder')

matrix_size= 192;
% shepp logan phantom
P = phantom('Modified Shepp-Logan',matrix_size);
figure; imagesc(P);  title('Shepp-Logan phantom')

%fourier transform
FTP=fft2(P);
figure;
image(abs(real(fftshift(FTP))))
title('Fourier transform of shepp logan phantom')

%% grid onto a radial trajectory
%First of all we want the k space data to be within a certain radius.
circle = zeros(192);
r=96;
for i = 1:192
    for j = 1:192
        if ((i-r).^2)+((j-r).^2) <= r.^2
            circle(i,j) = 1;
        end
    end
end
figure;
imshow(circle)
title('binary circle')
fft_circ=circle.*fftshift(FTP);
figure;
image(abs(fft_circ))
title('Fourier transform within circle of radius 96')

%% Inverse fourier transform of this gives
IFT_circ = ifft2(fft_circ);
figure;
imagesc(abs(IFT_circ));
title('IFT of fft only within radius of a circle')
%there is a small amount of blurring around the edges of the phantom

%% Next we want to only take some of the radial spokes
spokes_4 = zeros(192);
for i = 1:192
    for j = 1:192
        if j == 96
            spokes_4(i,j) = fft_circ(i,j);
        elseif i == 96
            spokes_4(i,j) = fft_circ(i,j);
        elseif i == j
            spokes_4(i,j) = fft_circ(i,j);
        elseif 96 - i == j - 96
            spokes_4(i,j) = fft_circ(i,j);
        end
    end
end
%We then IFT this
IFT_spokes_4 = ifft2(spokes_4);
figure;
imagesc(abs(IFT_spokes_4));
title('IFT of fft only 4 spokes')
%It is extremely unclear, but the eyes and edge are faintly visible

%% Attempting to do some radial gridding
%start off with point (8,134) (on edge of circle) and try to draw line to that
line = zeros(96,2);
log_1_line=zeros(192);
x= linspace(96,134,96);
y= linspace(96,8,96);
for i = 1:96
    line(i,1) = round(y(i));
    line(i,2) = round(x(i));
    log_1_line(line(i,1),line(i,2)) = 1;
end

k_1_line = zeros(192);

k_1_line = fft_circ .* log_1_line;
figure;
image(abs(k_1_line))
title('k space of a line from centre to edge of circle (8,134)')

%% Attempting finding indicies of minimums on LHS of the circle
j_pos_L = zeros(1,192);
rad_cont_L = zeros(192,r);
for i = 1:192
    for j = 1:r
        rad_cont_L(i,j) = ((i-r).^2)+((j-r).^2) - (r.^2);
    end
    minimum = min(abs(rad_cont_L(i,:)));
    j_pos_L(i) = find(abs(rad_cont_L(i,:))==minimum);
end

%Now for RHS
j_pos_R = zeros(1,192);
for i = 1:192
    j_pos_R(i) = r+(r-j_pos_L(i));
end

row = 1:192;
figure;
plot(j_pos_L,row,'-b');
hold on
plot(j_pos_R,row,'-b');
title('Boundary of circle')

%% Finding the lines to the edge of the whole circle

log_space = zeros(192);
% LHS first
for j = 1:192
    line=zeros(r,2);
    log_1_line = zeros(192);
    x=linspace(r,j_pos_L(j),r);
    y=linspace(r,row(j),r);
    for i=1:r
        line(i,1) = round(y(i));
        line(i,2) = round(x(i));
        log_1_line(line(i,1),line(i,2)) = 1;
    end
    log_space = log_space + log_1_line;
end

%RHS
for j = 1:192
    line=zeros(r,2);
    log_1_line = zeros(192);
    x=linspace(r,j_pos_R(j),r);
    y=linspace(r,row(j),r);
    for i=1:r
        line(i,1) = round(y(i));
        line(i,2) = round(x(i));
        log_1_line(line(i,1),line(i,2)) = 1;
    end
    log_space = log_space + log_1_line;
end

%Normalising all values to 1
for i = 1:192
    for j = 1:192
        if log_space(i,j)~=0;
           log_space(i,j)=1;
        end
    end
end
figure;
imshow(log_space)
title('Fully sampled radial grid')

%% Now IFT of fully sampled radial trajectory
k_rad_full = zeros(192);
k_rad_full = fft_circ .* log_space;
figure;
image(abs(k_rad_full))
title('k space of fully sampled radial trajectory')

%We then IFT this
IFT_rad_full = ifft2(k_rad_full);
figure;
imagesc(abs(IFT_rad_full));
title('IFT of full radial trajectory')
%aliasing around the corners is visible










