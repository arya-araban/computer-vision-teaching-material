clear all; 
close all;
clc;

leftImage = double(imread("..\Images\6\blending\orange.jpg"));
rightImage = double(imread("..\Images\6\blending\apple.jpg"));

iternum = 7;

if (size(leftImage) ~= size(rightImage))
    error('Input images are not the same size!')
end

[rows, cols, channels] = size(leftImage);

% mask gaussian
mask = double(zeros(rows, cols, channels));
mask(:, 1:floor(cols/2), :) = ones(rows, floor(cols/2), channels);
mask_pyramid = GaussianPyramid(mask, iternum);


% leftImage pyramid and rightImage pyramid
left_pyramid = LaplacianPyramid(leftImage, iternum);
right_pyramid = LaplacianPyramid(rightImage, iternum);

% get blend laplacian pyramid
blend_pyramid = cell(iternum, 1);
for i = 1:iternum
    blend_pyramid{i} = left_pyramid{i} .* mask_pyramid{i} + right_pyramid{i} .* (1 - mask_pyramid{i});
end

% reconstruct the blend image
blendImage = LaplacianReconstruct(blend_pyramid);

leftImage = uint8(leftImage);rightImage = uint8(rightImage);
blendImage = uint8(blendImage);

figure; 
subplot(1,2,1);imshow(leftImage); title('left Image');
subplot(1,2,2);imshow(rightImage); title('right Image');

figure;
subplot(1,2,1);imshow(blendImage); title('blend Image');

h=fix(size(leftImage,2)/2);
subplot(1,2,2); imshow(cat(2,leftImage(:,1:h,:), rightImage(:,h+1:end,:)));
title('half concat');

