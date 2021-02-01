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

%Now find a way to include this in with the 4 spokes k space without
%overlapping













