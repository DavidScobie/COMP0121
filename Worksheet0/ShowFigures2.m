function ShowFigures2(axial_slice,coronal_slice,sagittal_slice)
%SHOWFIGURES2 This function is used to image the the axial, coronal and
%sagittal slices. The images are grayscale and we have a fixed colorbar
%across the images.
%   The inputs here are the axial, coronal and sagittal slices that are to
%   be imaged.
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

