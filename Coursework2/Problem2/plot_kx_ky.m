function objHandle = plot_kx_ky(figHandle,kx,ky,color)
%PLOTSPIN3D This function plots the 3D precession of a spin precessing
%around the z axis in a magnetic field.
%   To be used with worksheet1 script.
%assigning colors to the plots.
%if nargin <3
color=['k'];
%end
%Plotting the vectors of the spins.


objHandle(1)=plot(figHandle, kx, ky,...
    'Color',color(1), 'Marker', '.', 'MarkerSize', 10, 'DisplayName','k_x,k_y');
hold on
%Plotting the points at the end of the spin vectors.



% legend;


% title(['t=',num2str(t,'%.2f'),'ms'])

end

