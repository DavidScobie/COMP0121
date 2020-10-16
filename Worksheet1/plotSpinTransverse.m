function objHandle = plotSpinTransverse(figHandle,xy_plane,colors)
%PLOTSPINTRANSVERSE Summary of this function goes here
%   Detailed explanation goes here

if nargin <3
    colors=['b','r'];
end

objHandle(1)=plot(figHandle, [0 xy_plane(1)], [0 xy_plane(2)],...
      'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);

objHandle(2)=plot(figHandle,xy_plane(1),xy_plane(2),...
     'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);
disp(objHandle)
end

