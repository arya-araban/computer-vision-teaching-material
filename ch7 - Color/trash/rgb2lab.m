clear, clc, close all;
image = imread('..\Images\5\Girl.jpg');

colorTransform = makecform('srgb2lab');
lab = applycform(image, colorTransform);

imshow(lab(:,:,3));