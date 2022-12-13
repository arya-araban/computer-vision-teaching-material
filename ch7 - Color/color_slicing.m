clc
close all
clear all

image = imread('..\Images\5\Strawberry.jpg');

% Convert to double.
image = im2double(image);

figure(1);
imshow(image);

[M, N, colorSpace] = size(image);

red   = image(:,:,1);
green = image(:,:,2);
blue  = image(:,:,3);

%W = 0.2549;

radius = 0.335;

sample_color = [0.6863, 0.1608, 0.1922];

for i=1:M;
    for j=1:N;
        
        sum = (red(i,j) - sample_color(1))^2 + (green(i,j) - sample_color(2))^2 + (blue(i,j) - sample_color(3))^2;
        if sum > radius^2
            image(i,j,1) = 0.5;
            image(i,j,2) = 0.5;
            image(i,j,3) = 0.5;
        end
        
    end
end   

figure(2);
imshow(image);