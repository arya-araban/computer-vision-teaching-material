%% Covolution theorem verification 

clear;

img=rgb2gray(imread('..\Images\4\Barbara.bmp'));  % simple.png is an AI generated fake image
subplot(1,2,1);
imshow(img)
title('Original image')
h = [ +1  0 -1;
      +2  0  -2;
      +1  0 -1]; %sobel filter for finding horizontal edges

PQ = (size(img))+size(h)-1; % in order to make convolution full, not circular
F = fft2(double(img), PQ(1), PQ(2));    % Taking the DFT of the image 
H = fft2(double(h), PQ(1), PQ(2)); %zero padding space where not same size as img
F_fH = H.*F;   % pixel wise multiplication in frequency domain = conv in spatial
out1 = ifft2(F_fH);
out1 = uint8(out1);
subplot(1, 2, 2);
imshow(out1,[])
title('After applying fourier filter')

out2 = conv2(img,h);
out2 = uint8(out2);
figure; imshow(out2);
immse(out1,out2)

