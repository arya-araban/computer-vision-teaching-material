%RGB HISTOGRAM MATCHING 
%by performing histogram matching on grayscaled images 
%and using the obtained mapping on each of the R,G,B
%channels seperately 

im1 = imread('..\Images\2\hm_main.jpg');
im2 = imread('..\Images\2\hm_ref.jpg');
out = uint8(zeros(size(im1)));
a = rgb2gray(im1);
b = rgb2gray(im2);

M = zeros(256,1,'uint8'); %// Store mapping - Cast to uint8 to respect data type
hist1 = imhist(a); %// Compute histograms
hist2 = imhist(b);
cdf1 = cumsum(hist1) / numel(a); %// Compute CDFs
cdf2 = cumsum(hist2) / numel(b);

%// Compute the mapping
for idx = 1 : 256
    [~,ind] = min(abs(cdf1(idx) - cdf2));
    M(idx) = ind-1;
end

%// Now apply the mapping to get first image to make
%// the image look like the distribution of the second image
for i = 1:3
out(:,:,i) = M(double(im1(:,:,i))+1);
end

figure;
subplot(2,2,1),imshow(im1); title('Main image');
subplot(2,2,2),imshow(im2); title('Reference image');
subplot(2,2,3),imshow(out); title('Result');
