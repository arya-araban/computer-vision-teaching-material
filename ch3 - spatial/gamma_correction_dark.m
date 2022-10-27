%Matlab Code
clear;
img = imread('..\Images\2\HE2.jpg');

gammas = [0.9, 0.6, 0.3];
 
figure; subplot(2,2,1); imshow(img); title('Original Image');

for n = 1 : length(gammas)
    img2 = double(img) .^ gammas(n); % applying gamma to image
    img2 = [img2 - min(img2(:))] ./ ( max(img2(:)) - min(img2(:)) ); %range to [0,1]
    subplot(2,2,n+1); imshow(img2); title(strcat('\gamma = ', num2str(gammas(n),2)));
end