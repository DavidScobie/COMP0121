function objHandle = plotSpinTransverse(figHandle,vecMu,colors)
%PLOTSPINTRANSVERSE This function outputs the object handles required to
%plot the precession in the x-y plane of a spin precessing around the z
%axis.
%   To be used with the worksheet1 script.
%assigning colors to the plots.
if nargin <3
    colors=['b','r'];
end
%Plotting the vectors of the spins.
objHandle(1)=plot(figHandle, [0 vecMu(1)], [0 vecMu(2)],...
      'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
%Plotting the points at the end of the spin vectors.
objHandle(2)=plot(figHandle,vecMu(1),vecMu(2),...
     'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);

end

