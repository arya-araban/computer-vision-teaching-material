clear;
im1 = imread('C:\Users\Arya\Desktop\CV_code\Images\1\Goldhill.bmp');
im2 = imread('C:\Users\Arya\Desktop\CV_code\Images\1\Elaine.bmp');

figure(1);
subplot(2,3,1),imshow(im1); title ('IMAGE1');
subplot(2,3,2),imshow(im2); title ('IMAGE2');

res = im1 + im2; 
subplot(2,3,3),imshow(res); title ('IM1 + IM2');

im1 = double(im1); im2 = double(im2);

res = im1 - im2; 
res = uint8((res + 255)/2);
subplot(2,3,4),imshow(res); title ('IM1 - IM2');

res = im2 - im1; 
res = uint8((res + 255)/2);
subplot(2,3,5),imshow(res); title ('IM2 - IM1');