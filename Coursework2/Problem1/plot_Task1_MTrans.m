function objHandle = plot_Task1_MTrans(t,figHandle,Mx,My,colors)
%PLOTSPIN3D This function plots the 3D precession of a spin precessing
%around the z axis in a magnetic field.
%   To be used with worksheet1 script.
%assigning colors to the plots.
%if nargin <3
colors=['b','r'];
%end
%Plotting the vectors of the spins.


objHandle(1)=plot(figHandle, t, Mx,...
    'Color',colors(1), 'Marker', '.', 'MarkerSize', 10, 'DisplayName','M_x');
hold on
%Plotting the points at the end of the spin vectors.
objHandle(2)=plot(figHandle,t,My,...
    'Color', colors(2), 'Marker', '.', 'MarkerSize', 10, 'DisplayName','M_y');
hold on


legend;


% title(['t=',num2str(t,'%.2f'),'ms'])

end

