clear;
img1 = imread('..\Images\1\Elaine.bmp');
%img1 = imnoise( img1,'salt & pepper');
img1 = imnoise( img1,'salt & pepper',0.7);
img2 = im2double(img1);
sz = 10; %filter size

h = ones(sz,sz)/(sz^2);
img2 = conv2(img2,h,'same');
img3 = medfilt2(im2double(img1),[sz sz]);
%img3 = medfilt2(im2double(img3),[sz sz]);
figure;
subplot(1,3,1); imshow(img1); title('Original Image');
subplot(1,3,2); imshow(img2); title('Image after Smoothing Filter');
subplot(1,3,3); imshow(img3); title('Image after Median Filter');