clear, clc, close all;
colorValues = (0:0.2:1).';

webSafeMap = [repmat(colorValues,36,1) ...
              kron(colorValues,ones(36,1)) ...
              repmat(kron(colorValues,ones(6,1)),6,1)];
          
image = imread('..\Images\5\Girl.bmp');

safe_image = ind2rgb(rgb2ind(image,webSafeMap),webSafeMap);

figure;
subplot(1,2,1); imshow(image); title('original');
subplot(1,2,2); imshow(safe_image); title('safe image');