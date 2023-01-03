clear 
img1 = imread('..\Images\2\moon.jpg');
img1 = rgb2gray(img1); img1 = im2double(img1);
lap = [-1 -1 -1; -1 8 -1; -1 -1 -1;];
img2 = conv2(img1, lap, 'same');
img3 = uint8(255 * mat2gray(img2));
img4 = img1 + img2;
figure;
subplot(2,2,1); imshow(img1); title('Moon Image');
subplot(2,2,2); imshow(img2); title('Laplacian Filtered Moon Image');
subplot(2,2,3); imshow(img3); title('Laplacian Image Scaled to Full Dynamic Range');
subplot(2,2,4); imshow(img4); title('Laplacian-enhanced Original Image');