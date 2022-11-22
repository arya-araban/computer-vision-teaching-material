clear;

x = 127;y=127;
im = zeros(x,y);
distance = 10;
im(ceil(y/2)+distance,ceil(x/2)) = 255;
im(ceil(y/2)-distance,ceil(x/2)) = 255;


out = ifftshift(im);
out = real(ifft2(out));

figure;
subplot(1,2,1);imshow(uint8(im)); title('fourier')
subplot(1,2,2);imshow(out,[]); title('spatial')