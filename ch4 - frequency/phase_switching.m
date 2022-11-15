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
out1 = real(ifft2(out1));
out2 = real(ifft2(out2));

% Show the images
figure;
imshow(uint8(out1), []); title('magnitude of first, phase of second');
figure;
imshow(uint8(out2), []); title('magnitude of second, phase of first');