function objHandle = plotSpin3D(no_of_spins,t,figHandle,vecMus,colors)
%PLOTSPIN3D This function plots the 3D precession of a spin precessing
%around the z axis in a magnetic field.
%   To be used with worksheet1 script.
%assigning colors to the plots.
%if nargin <3
    colors=['b','r'];
%end
%Plotting the vectors of the spins.
    j=size(vecMus);
    k=j(2);
    for i = 1:k
        objHandle(1)=plot3(figHandle, [i-((no_of_spins+1)./2) vecMus(1,i)], [0 vecMus(2,i)],...
            [0 vecMus(3,i)], 'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
        %Plotting the points at the end of the spin vectors.
        objHandle(2)=plot3(figHandle,vecMus(1,i),vecMus(2,i),vecMus(3,i),...
            'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);
    end

title(['t=',num2str(t,'%.2f'),'ms'])

end
