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
axial_slice = rot90(axial_slice,1);
%Apply spacings to the slices
coronal_slice = imresize(coronal_slice,[(181.*spacings(3)) 217]);
%finding dimensions of axial slice
axial_size=size(axial_slice);

%Image the slices
subplot(2,2,1); imagesc(axial_slice)
subplot(2,2,2); imagesc(coronal_slice)
subplot(2,2,3); imagesc(sagittal_slice)

disp('hello world');
end

