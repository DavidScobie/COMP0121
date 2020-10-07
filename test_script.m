filename = 'C:\PHD\Computationl MRI\COMP0121\t1_icbm_normal_1mm_pn0_rf0.rawb';
dimensions = [181,217,181];
spacings = 0;
fileID = fopen(filename,'r','l');
data = fread(fileID);
fclose(fileID);
volume = reshape(data,dimensions(1),dimensions(2),dimensions(3));
aslice = squeeze(volume(50,:,:));
imagesc(aslice)
%%
B=[2,2,2,2;3,3,3,3;4,4,4,4;5,5,5,5];
figure; imagesc(B)
figure; imagesc(B(2:3,2:3))
%%