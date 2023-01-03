clear;

im = imread('..\Images\4\Baboon.bmp');
im = rgb2gray(im);

fft_result=fftshift(fft2(im));                         
mag=abs(fft_result);                           
phase=angle(fft_result);

figure; 
subplot(2,2,1);imshow(im);title('original image');
subplot(2,2,2);imshow(mag,[]); title('magnitude (no scale)');
subplot(2,2,3);imshow(log(mag),[]); title('magnitude with log scale');
subplot(2,2,4);imshow(phase);title('phase');





