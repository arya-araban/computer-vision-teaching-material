clear;
%IMAGE1
x = 127;y=127;
im1 = zeros(x,y);
distance = 10;
im1(ceil(x/2)+distance,ceil(y/2)+distance) = 255;
im1(ceil(x/2)-distance,ceil(y/2)-distance) = 255;

out1 = ifftshift(im1);
out1 = real(ifft2(out1));
%IMAGE2
im2 = zeros(x,y);
distance = 2;
im2(ceil(x/2),ceil(y/2)-distance) = 255;
im2(ceil(x/2),ceil(y/2)+distance) = 255;

out2 = ifftshift(im2);
out2 = real(ifft2(out2));

%SUM 
im_sum = im1+im2;
out_sum = ifftshift(im_sum);
out_sum = real(ifft2(out_sum));
figure;

%plotting
subplot(2,3,1);imshow(uint8(im1)); 
subplot(2,3,2);imshow(uint8(im2));
subplot(2,3,3);imshow(uint8(im_sum));
subplot(2,3,4);imshow(out1,[]); 
subplot(2,3,5);imshow(out2,[]);
subplot(2,3,6);imshow(out_sum,[]);