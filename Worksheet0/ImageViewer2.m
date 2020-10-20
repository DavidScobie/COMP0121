function ImageViewer2(filename,dimensions,spacings,xcoord,ycoord,zcoord)
% UNTITLED 
% Inputs
% filename: The filename is the image you want to view.
% dimensions: Enter the dimensions of the original image (as if all the spacings are
% 1). 
% spacings: Enter the spacings between the pixels in each dimension.
% xcoord, ycoord, zcoord: Enter the coordinates where you would like the image to be centred.

% An exmaple of the input of this function:
% ImageViewer2('C:\PHD\Computationl MRI\COMP0121\t1_icbm_normal_1mm_pn0_rf0.rawb',[181,217,181],[1,1,3],100,100,100)

% Open the raw byte file
%Read the file in
fileID = fopen(filename,'r','l');
data = fread(fileID);
fclose(fileID);
%Reshape into the 3D spatial coordinates
volume = reshape(data,dimensions(1),dimensions(2),dimensions(3));
%Choose a slice through each axial plane
sagittal_slice = squeeze(volume(xcoord,:,:));
coronal_slice = squeeze(volume(:,ycoord,:));
axial_slice = squeeze(volume(:,:,zcoord));
%Rotate the slices by 90 degrees (to align with ITK-SNAP)
sagittal_slice = rot90(sagittal_slice,1);
coronal_slice = rot90(coronal_slice,1);
axial_slice = rot90(axial_slice,3);

%finding dimensions of axial slice
axial_size=size(axial_slice);

% %Apply spacings to the slices
% axial_slice = imresize(axial_slice,[(dimensions(2).*spacings(2)) dimensions(1).*spacings(1)]);
% sagittal_slice = imresize(sagittal_slice,[(dimensions(3).*spacings(3)) dimensions(2).*spacings(2)]);
% coronal_slice = imresize(coronal_slice,[(dimensions(3).*spacings(3)) dimensions(1).*spacings(1)]);
%%
%Sagittal
%snipping the bottom off
rem=(abs(round(dimensions(3)./spacings(3))-(dimensions(3)./spacings(3)))).*spacings(3);
siz=size(sagittal_slice);
sagittal_slice=sagittal_slice(1:siz(1)-rem,:);

%Snipping the side off
rem1=(abs(round(dimensions(2)./spacings(2))-(dimensions(2)./spacings(2)))).*spacings(2);
sagittal_slice=sagittal_slice(:,1:siz(2)-rem1);

%Blurring sagittal in vert direction
for n=1:((dimensions(3)-rem).*(dimensions(2)-rem1))./spacings(3)
    sagittal_slice((spacings(3).*n)-spacings(3)+1:spacings(3).*n)=sagittal_slice((spacings(3).*n)-spacings(3)+1);
end
 
sagittal_slice=rot90(sagittal_slice,1);
%Blurring sagittal in horizontal direction
for n=1:((dimensions(2)-rem1).*(dimensions(3)-rem))./spacings(2)
    sagittal_slice((spacings(2).*n)-spacings(2)+1:spacings(2).*n)=sagittal_slice((spacings(2).*n)-spacings(2)+1);
end
sagittal_slice=rot90(sagittal_slice,3);
% figure; imagesc(sagittal_slice); title('sagittal')
%%
%Coronal
%snipping the bottom off
rem=(abs(round(dimensions(3)./spacings(3))-(dimensions(3)./spacings(3)))).*spacings(3);
siz=size(coronal_slice);
coronal_slice=coronal_slice(1:siz(1)-rem,:);

%Snipping the side off
rem1=(abs(round(dimensions(1)./spacings(1))-(dimensions(1)./spacings(1)))).*spacings(1);
coronal_slice=coronal_slice(:,1:siz(2)-rem1);

%Blurring coronal in vert direction
for n=1:((dimensions(3)-rem).*(dimensions(1)-rem1))./spacings(3)
    coronal_slice((spacings(3).*n)-spacings(3)+1:spacings(3).*n)=coronal_slice((spacings(3).*n)-spacings(3)+1);
end
 
coronal_slice=rot90(coronal_slice,1);
%Blurring coronal in horizontal direction
for n=1:((dimensions(1)-rem1).*(dimensions(1)-rem))./spacings(1)
    coronal_slice((spacings(1).*n)-spacings(1)+1:spacings(1).*n)=coronal_slice((spacings(1).*n)-spacings(1)+1);
end
coronal_slice=rot90(coronal_slice,3);
% figure; imagesc(coronal_slice); title('coronal')

%%
%Axial

%snipping the bottom off
rem=(abs(round(dimensions(2)./spacings(2))-(dimensions(2)./spacings(2)))).*spacings(2);
siz=size(axial_slice);
axial_slice=axial_slice(1:siz(1)-rem,:);

%Snipping the side off
rem1=(abs(round(dimensions(1)./spacings(1))-(dimensions(1)./spacings(1)))).*spacings(1);
axial_slice=axial_slice(:,1:siz(2)-rem1);

%Blurring axial in vert direction
for n=1:((dimensions(2)-rem).*(dimensions(1)-rem1))./spacings(2)
    axial_slice((spacings(2).*n)-spacings(2)+1:spacings(2).*n)=axial_slice((spacings(2).*n)-spacings(2)+1);
end
 
axial_slice=rot90(axial_slice,1);
%Blurring axial in horizontal direction
for n=1:((dimensions(1)-rem1).*(dimensions(2)-rem))./spacings(1)
    axial_slice((spacings(1).*n)-spacings(1)+1:spacings(1).*n)=axial_slice((spacings(1).*n)-spacings(1)+1);
end
axial_slice=rot90(axial_slice,3);
% figure; imagesc(axial_slice); title('axial')

%Image the slices to show spacings
ShowFigures2(axial_slice,coronal_slice,sagittal_slice)


end

