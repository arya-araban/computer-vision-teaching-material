clc
close all
clear all

image = imread('..\Images\5\overexposed.jpg');

[rows, columns] = size(image);

HSV = rgb2hsv(image);

H = HSV(:,:,1);
S = HSV(:,:,2);
% I = (R + G + B) / 3
I = HSV(:,:,3);

uint8I = uint8(I.*255);

% Intensity histogram equalization.
uint8NewI = MyHist(uint8I);
doubleNewI  = uint8NewI./255; 


HSV(:,:,3) = doubleNewI;
rgbResult = hsv2rgb(HSV);


subplot(2,2,1)
imshow(image);
title('Input Image')

subplot(2,2,2)
histogram(image)
title('Input Image Histogram')

subplot(2,2,3)
imshow(rgbResult);
title('After Histogram Equalization')

subplot(2,2,4)
histogram(uint8(rgbResult.*255))
title('Output Image Histogram')