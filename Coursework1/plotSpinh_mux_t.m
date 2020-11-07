function objHandle = plotSpinh_mux_t(figHandle,vecMu,deltaT,colors)
%PLOTSPINH_MUX_T This plots the time variance of the mux component of a
%spin vector precessing around the z axis.
%   To be used with the worksheet1 script.
%assigning colors to the plots.
% if nargin <3
    colors=['b','r'];
% end
%Plotting the vectors of the spins.
objHandle(1)=plot(figHandle, [deltaT deltaT], [0 vecMu(1)],...
      'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
%Plotting the points at the end of the spin vectors.
objHandle(2)=plot(figHandle,deltaT,vecMu(1),...
      'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);

end

