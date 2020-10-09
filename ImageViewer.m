function ImageViewer(filename,dimensions,spacings,xcoord,ycoord,zcoord)
%UNTITLED Summary of this function goes here
% Open the raw byte file
% ImageViewer('C:\PHD\Computationl MRI\COMP0121\t1_icbm_normal_1mm_pn0_rf0.rawb',[181,217,181],[1,1,3],100,100,100)

%Read the file in
fileID = fopen(filename,'r','l');
data = fread(fileID);
fclose(fileID);
%Reshape into the 3D spatial coordinates
volume = reshape(data,dimensions(1),dimensions(2),dimensions(3));
%Choose a slice through each axial plane
coronal_slice = squeeze(volume(xcoord,:,:));
sagittal_slice = squeeze(volume(:,ycoord,:));
axial_slice = squeeze(volume(:,:,zcoord));
%Rotate the slices by 90 degrees (to align with ITK-SNAP)
coronal_slice = rot90(coronal_slice,1);
sagittal_slice = rot90(sagittal_slice,1);
axial_slice = rot90(axial_slice,3);

%finding dimensions of axial slice
axial_size=size(axial_slice);
disp(axial_size)

%Apply spacings to the slices
axial_slice = imresize(axial_slice,[(dimensions(2).*spacings(2)) dimensions(1).*spacings(1)]);
coronal_slice = imresize(coronal_slice,[(dimensions(3).*spacings(3)) dimensions(2).*spacings(2)]);
sagittal_slice = imresize(sagittal_slice,[(dimensions(3).*spacings(3)) dimensions(1).*spacings(1)]);

%working out image areas
%axial bounds
axial_y_low_bound = round(((dimensions(2).*spacings(2))./2)-(dimensions(2)./2))+1;
axial_y_up_bound  = round(((dimensions(2).*spacings(2))./2)+(dimensions(2)./2));
axial_x_low_bound = round(((dimensions(1).*spacings(1))./2)-(dimensions(1)./2))+1;
axial_x_up_bound  = round(((dimensions(1).*spacings(1))./2)+(dimensions(1)./2));

%coronal bounds
coronal_z_low_bound = round(((dimensions(3).*spacings(3))./2)-(dimensions(3)./2))+1;
coronal_z_up_bound  = round(((dimensions(3).*spacings(3))./2)+(dimensions(3)./2));
coronal_y_low_bound = round(((dimensions(2).*spacings(2))./2)-(dimensions(2)./2))+1;
coronal_y_up_bound  = round(((dimensions(2).*spacings(2))./2)+(dimensions(2)./2));

%sagittal bounds
sagittal_z_low_bound = round(((dimensions(3).*spacings(3))./2)-(dimensions(3)./2))+1;
sagittal_z_up_bound  = round(((dimensions(3).*spacings(3))./2)+(dimensions(3)./2));
sagittal_x_low_bound = round(((dimensions(1).*spacings(1))./2)-(dimensions(1)./2))+1;
sagittal_x_up_bound  = round(((dimensions(1).*spacings(1))./2)+(dimensions(1)./2));

% %Image the slices
% subplot(2,2,1); imagesc(axial_slice)
% subplot(2,2,2); imagesc(coronal_slice)
% subplot(2,2,3); imagesc(sagittal_slice)

%Image the slices
subplot(2,2,1); imagesc(axial_slice(axial_y_low_bound:axial_y_up_bound,axial_x_low_bound:axial_x_up_bound));
subplot(2,2,2); imagesc(coronal_slice(coronal_z_low_bound:coronal_z_up_bound,coronal_y_low_bound:coronal_y_up_bound));
subplot(2,2,3); imagesc(sagittal_slice(sagittal_z_low_bound:sagittal_z_up_bound,sagittal_x_low_bound:sagittal_x_up_bound));
end

