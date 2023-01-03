clear, clc, close all;
im = imread('coloredChips.png');
imshow(im);
im(:,:,1)= 255 - im(:,:,1); % cyan
im(:,:,2)= 255 - im(:,:,2); % magneta 
im(:,:,3)= 255 - im(:,:,3); % yellow
figure, imshow(im);