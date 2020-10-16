function objHandle = plotSpin3D(figHandle,vecMu,colors)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin <3
    colors=['b','r'];
end
objHandle(1)=plot3(figHandle, [0 vecMu(1)], [0 vecMu(2)],...
    [0 vecMu(3)], 'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);

objHandle(2)=plot3(figHandle,vecMu(1),vecMu(2),vecMu(3),...
    'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);
disp(objHandle)
end
