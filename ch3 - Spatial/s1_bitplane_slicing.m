% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==
% % visualizing the impact of removing certain bits for each pixel 
% % in grayscale image. 
% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==
clear;
img = imread('..\Images\2\Cameraman.bmp');

img7 = img; img6 = img; img5 = img; img4 = img;
img3 = img; img2 = img; img1 = img; img0 = img;

%double is always 1 for any value higher than 1
img7 = double(bitand(img,128)); img6 = double(bitand(img,64));
img5 = double(bitand(img,32)); img4 = double(bitand(img,16));
img3 = double(bitand(img,8)); img2 = double(bitand(img,4));
img1 = double(bitand(img,2)); img0 = double(bitand(img,1));
%note: the reason msb gives more info is that you're taking 
%threshold on a much higher number (L/2) compared to others.


img76 = bitand(img, 0b11000000);
img765 = bitand(img, 0b11100000);
img7654 = bitand(img, 0b11110000);

figure;
subplot(2,2,1); imshow(img7); title('Bit-plane 7');
subplot(2,2,2); imshow(img6); title('Bit-plane 6');
subplot(2,2,3); imshow(img5); title('Bit-plane 5');
subplot(2,2,4); imshow(img4); title('Bit-plane 4');

figure;
subplot(2,2,1); imshow(img3); title('Bit-plane 3');
subplot(2,2,2); imshow(img2); title('Bit-plane 2');
subplot(2,2,3); imshow(img1); title('Bit-plane 1');
subplot(2,2,4); imshow(img0); title('Bit-plane 0');

figure;
subplot(2,2,1); imshow(img); title('original image');
subplot(2,2,2); imshow(img76); title('Bit-plane 76');
subplot(2,2,3); imshow(img765); title('Bit-plane 765');
subplot(2,2,4); imshow(img7654); title('Bit-plane 7654');

