function ShowFigures2(axial_slice,coronal_slice,sagittal_slice)
%SHOWFIGURES2 Summary of this function goes here
%   Detailed explanation goes here
figure(1);
imagesc(axial_slice);
fig=gcf;
ax=fig.CurrentAxes;
caxis(ax,[0 255]);
axis equal; 
axis xy;  
title('Axial'); 
colormap('gray');
colorbar;


figure(2); 
imagesc(coronal_slice); 
fig=gcf;
ax=fig.CurrentAxes;
caxis(ax,[0 255]);
axis equal; 
title('Coronal');
colormap('gray');
colorbar;


figure (3);
imagesc(sagittal_slice); 
fig=gcf;
ax=fig.CurrentAxes;
caxis(ax,[0 255]);
axis equal; 
title('Sagittal');
colormap('gray');
colorbar;
end

