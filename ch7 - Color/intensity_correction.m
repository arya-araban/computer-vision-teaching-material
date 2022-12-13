clear, clc, close all;
im = imread('..\Images\5\overexposed.jpg');
imshow(im);
th = 0.7;
im(:,:,1)= th * im(:,:,1); % cyan
im(:,:,2)= th * im(:,:,2); % magneta 
im(:,:,3)= th * im(:,:,3); % yellow
figure, imshow(im);
