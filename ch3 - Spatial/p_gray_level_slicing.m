clear;

main_img = imread('..\Images\2\HE1.jpg');

figure;imshow(main_img);

img1 = main_img; % binary scaled

img2 = main_img; % linear scaled

% Binary Gray-level Slicing Transform

% x and y only for showing transformation plot 
x = 0:255;

y1 = 10*ones(size(x)); 

y1(128:240) = 200;
a = find(main_img>=128 & main_img<=240);
img1(find(main_img>=128 & main_img<=240)) = 200;

img1(find(main_img<128)) = 10;

img1(find(main_img>240)) = 10;

% Linear Gray-level Slicing Transform

y2 = x;

y2(100:150) = 200;

img2(find(main_img>=100 & main_img<=150)) = 200;

figure;

subplot(2,2,1); plot(x,y1); title('Binary Gray-level Slicing Transform');
axis([0 255 0 255]); xlabel('Input Gray Level, r');
ylabel('Output Gray Level, s');

subplot(2,2,2); plot(x,y2); title('Linear Gray-level Slicing Transform');
axis([0 255 0 255]); xlabel('Input Gray Level, r');
ylabel('Output Gray Level, s');

subplot(2,2,3); imshow(img1); title('Binary Gray-level sliced image');

subplot(2,2,4); imshow(img2); title('Linear Gray-level sliced image');