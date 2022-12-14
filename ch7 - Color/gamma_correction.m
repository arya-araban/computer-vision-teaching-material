clear, clc, close all;

image = imread('..\Images\5\paint.jpg');
figure; subplot(1,2,1); imshow(image); title('original')

im = gammaMap(image,2.5);

subplot(1,2,2);imshow(im); title('gamma corrected')