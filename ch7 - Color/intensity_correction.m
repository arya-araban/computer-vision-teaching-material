clear, clc, close all;
im = imread('..\Images\5\overexposed.jpg');
imshow(im);
th = 0.7;
im(:,:,1)= th * im(:,:,1); 
im(:,:,2)= th * im(:,:,2);
im(:,:,3)= th * im(:,:,3);
figure, imshow(im);
