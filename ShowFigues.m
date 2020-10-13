function ShowFigues(axial_slice,coronal_slice,sagittal_slice,axial_y_low_bound,axial_y_up_bound,axial_x_low_bound,axial_x_up_bound,coronal_z_low_bound,coronal_z_up_bound,coronal_y_low_bound,coronal_y_up_bound,sagittal_z_low_bound,sagittal_z_up_bound,sagittal_x_low_bound,sagittal_x_up_bound)
%SHOWFIGUES This function shows the axial, sagittal and coronal figures
%   With the figures, we also have titles, axis adjustments, colorbar and
%   colormap.
figure(1);
imagesc(axial_slice(axial_y_low_bound:axial_y_up_bound,axial_x_low_bound:axial_x_up_bound));
axis equal; 
axis xy;  
title('Axial'); 
colormap('gray');
colorbar;
figure(2); 
imagesc(coronal_slice(coronal_z_low_bound:coronal_z_up_bound,coronal_y_low_bound:coronal_y_up_bound)); 
axis equal; 
title('Sagittal');
colormap('gray');
colorbar;
figure (3);
imagesc(sagittal_slice(sagittal_z_low_bound:sagittal_z_up_bound,sagittal_x_low_bound:sagittal_x_up_bound)); 
axis equal; 
title('Coronal');
colormap('gray');
colorbar;
end

