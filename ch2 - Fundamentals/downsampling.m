clear; 


img = imread('..\Images\1\Elaine.bmp');

figure; imshow(img); title('Original Image')

%downsampling, with sample rate of Fs
Fs=4;  
sampled_image= img(1:Fs:end, 1:Fs:end);
figure; 
imshow(sampled_image);
title('Image After Sampling')

imwrite(sampled_image, '..\Images\1\Elaine_Downsampled.bmp');