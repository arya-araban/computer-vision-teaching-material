clear;

img1 = imread('..\Images\2\Hubble.jpg');
img1 = rgb2gray(img1);
img1 = im2double(img1); img2 = im2double(img1);

sz = 15;
h = ones(sz,sz)/(sz^2); %box filter

img2 = conv2(img2,h,'same');

th = 0.75*max(img2(:));
img3 = img2;
img3(find(img2>=th)) = 1;
img3(find(img2<th)) = 0;
figure;
subplot(1,3,1); imshow(img1); title('Original Hubble Image');
subplot(1,3,2); imshow(img2); title('Image after Smoothing Filter');
subplot(1,3,3); imshow(img3); title('Thresholded Smoothed Hubble Image');