%removing phase and magnitude of an image
clear; 
% Read the images in   
im=double(imread('..\Images\4\F16.bmp'));


% Find dimensions and extent of the FFT


% Take the FFT
Image1_FFT=fft2(im);



% Find the inverse images
out1 = real(ifft2(out1));
out2 = real(ifft2(out2));

% Show the images
figure;
imshow(uint8(out1), []); title('magnitude of first, phase of second');
figure;
imshow(uint8(out2), []); title('magnitude of second, phase of first');