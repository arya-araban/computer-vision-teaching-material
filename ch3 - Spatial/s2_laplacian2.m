clear;
img1 = im2double(imread('..\Images\1\Elaine.bmp'));

lapa = [0 -1 0; -1 5 -1; 0 -1 0;];
lapb = [-1 -1 -1; -1 9 -1; -1 -1 -1;];
img2 = conv2(img1, lapa, 'same');
img3 = conv2(img1, lapb, 'same');
figure;
subplot(2,2,1); imshow(img1); title('original Image');
subplot(2,2,2); imshow(img2); title('Composite 4-neighbor Laplacian Image');
subplot(2,2,3); imshow(img3); title('Composite 8-neighbor Laplacian Image');