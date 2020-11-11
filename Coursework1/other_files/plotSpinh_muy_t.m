function objHandle = plotSpinh_muy_t(figHandle,vecMu,deltaT,colors)
%PLOTSPINH_MUY_T This function plots the time dependance of the muy spin
%vector for a magnetic field along the z axis.
%   To be used with the worksheet1 script.
%assigning colors to the plots.
% if nargin <3
    colors=['b','r'];
% end
%Plotting the vectors of the spins.
objHandle(1)=plot(figHandle, [deltaT deltaT], [0 vecMu(2)],...
      'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
%Plotting the points at the end of the spin vectors.
objHandle(2)=plot(figHandle,deltaT,vecMu(2),...
      'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);

end
