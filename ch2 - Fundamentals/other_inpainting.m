% nearest neighbour inpainting 
clear; 

in= imread('..\Images\1\Elaine_Downsampled.bmp');

og_image = imread('..\Images\1\Elaine.bmp');

interpolation_methods = {'nearest', 'bilinear', 'bicubic', 'box'};

figure(1);
subplot(2,3,1),imshow(og_image); title ('ORIGINAL IMAGE');

for i = 1:length(interpolation_methods) 
    B = imresize(in,[size(og_image,1),size(og_image,2)],interpolation_methods{i});
    subplot(2,3,i+1),imshow(B); title (interpolation_methods{i});
end 
