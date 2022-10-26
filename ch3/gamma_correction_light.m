clear;
img = imread('..\Images\2\HE4.jpg');

gammas = [1.3, 1.6, 1.9];
 
figure; subplot(2,2,1); imshow(img); title('Original Image');

for n = 1 : length(gammas)
    img2 = double(img).^(gammas(n)); % applying gamma to image
    img2 = [img2 - min(img2(:))] ./ ( max(img2(:)) - min(img2(:)) ); %range to [0,255]
    subplot(2,2,n+1); imshow(img2); title(strcat('\gamma = ', num2str(gammas(n),2)));
end