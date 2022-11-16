clear; 
im = rgb2gray(imread('..\Images\4\Lena.bmp'));

[m,n] = size(im);

% creating a circle with euclidean distance. 
% this circle is the same size as image and the center is 0 
[x,y] = meshgrid(-(m/2):(m/2)-1, -(n/2):(n/2)-1);
z = sqrt(x.^2+y.^2);
r=20; %radius
h = z<r; %the filter 

% UNCOMMENT FOLLOWING LINE FOR HIGH PASS INSTEAD OF LOW PASS
%h = 1 - h; 

%fourier operations
im_fft=fftshift(fft2(im));

subplot(2,2,1); imshow(log(abs(im_fft)),[]);title('fourier');
subplot(2,2,2); imshow(h);title(strcat('filter with radius=', num2str(r)));

out = im_fft .* h;
subplot(2,2,3); imshow(log(abs(out)),[]);title('fft*h')

out = uint8(ifft2(ifftshift(out)));
subplot(2,2,4); imshow(uint8(out));title('result')

