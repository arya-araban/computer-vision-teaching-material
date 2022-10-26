im1 = imread('..\Images\2\HE3.jpg');
im2 = imread('..\Images\2\HE4.jpg');

M = zeros(256,1,'uint8'); %// Store mapping - Cast to uint8 to respect data type
hist1 = imhist(im1); %// Compute histograms
hist2 = imhist(im2);
cdf1 = cumsum(hist1) / numel(im1); %// Compute CDFs
cdf2 = cumsum(hist2) / numel(im2);

%// Compute the mapping
for idx = 1 : 256
    [~,ind] = min(abs(cdf1(idx) - cdf2));
    M(idx) = ind-1;
end

%// Now apply the mapping to get first image to make
%// the image look like the distribution of the second image
out = M(double(im1)+1);

figure;
subplot(2,2,1),imshow(im1); title('Main image');
subplot(2,2,2),imshow(im2); title('Reference image');
subplot(2,2,3),imshow(out); title('Result');
