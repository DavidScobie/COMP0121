function objHandle = plotSpinh_mux_t(figHandle,vecMu,deltaT,colors)
%PLOTSPINH_MUX_T Summary of this function goes here
%   Detailed explanation goes here
% if nargin <3
    colors=['b','r'];
% end

objHandle(1)=plot(figHandle, [deltaT deltaT], [0 vecMu(1)],...
      'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);

objHandle(2)=plot(figHandle,deltaT,vecMu(1),...
      'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);

end

