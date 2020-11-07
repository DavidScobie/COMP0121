function objHandle = plotSpin3(figHandle,vecMu,colors)
%PLOTSPIN3D This function plots the 3D precession of a spin precessing
%around the z axis in a magnetic field.
%   To be used with worksheet1 script.
%assigning colors to the plots.
if nargin <3
    colors=['b','r'];
end
%Plotting the vectors of the spins.
% objHandle(1)=plot3(figHandle, [0 vecMu(1)], [0 vecMu(2)],...
%     [0 vecMu(3)], 'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
%Plotting the points at the end of the spin vectors.
objHandle(2)=plot3(figHandle,vecMu(1),vecMu(2),vecMu(3),...
    'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);

end