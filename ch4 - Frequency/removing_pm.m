%removing phase and magnitude of an image
clear; 
og_image = rgb2gray(imread('..\Images\4\Lena.bmp'));

im=double(og_image);

im_fft = fft2(im);

%Find the magnitudes and phase responses
mag = abs(im_fft); % magnitude
pha = angle(im_fft); % phase

mag_ones = ones(size(mag));
phase_zeros = zeros(size(pha));

% Remove mag (out1) and phase (out2)
out1 = mag_ones .* exp(j*pha); 
out2 = mag .* exp(j*phase_zeros);

% Find the inverse images
out1 = real(ifft2(out1)); 
out2 = real(ifft2(out2));
% Show the images
figure; 
subplot(2,2,1); imshow(og_image); title('original image');
subplot(2,2,2); imshow(out1,[]); title('magnitude removed, same phase');
subplot(2,2,3); imshow(uint8(out2),[]); title('phase removed, same magnitude');
