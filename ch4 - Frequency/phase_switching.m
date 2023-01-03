%removing phase and magnitude of an image
clear; 
% Read the images in   
Image1=double(imread('..\Images\4\F16.bmp'));
Image2=double(imread('..\Images\4\Barbara.bmp'));

% Find dimensions and extent of the FFT


% Take the FFT
Image1_FFT=fft2(Image1);
Image2_FFT=fft2(Image2);

% NEW - Find the magnitudes and phase responses
mag1 = abs(Image1_FFT);
mag2 = abs(Image2_FFT);
pha1 = angle(Image1_FFT);
pha2 = angle(Image2_FFT);

% Recompute frequency responses by swapping the phases
out1 = mag1 .* exp(j*pha2); 
out2 = mag2 .* exp(j*pha1);

% Find the inverse images
out1 = ifft2(out1);
out2 = ifft2(out2);

% Show the images
figure;
subplot(2,2,1);imshow(uint8(Image1));title('First Image')
subplot(2,2,2);imshow(uint8(out1), []); title('magnitude of first, phase of second');
subplot(2,2,3);imshow(uint8(Image2));title('Second Image')
subplot(2,2,4);imshow(uint8(out2), []); title('magnitude of second, phase of first');