% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==
% % Grayscale histogram matching 
% % first image's histogram will try to match reference image's 
% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==
im = imread('..\Images\2\HE3.jpg');
ref = imread('..\Images\2\HE4.jpg');

M = zeros(256,1,'uint8'); %// Store mapping - Cast to uint8 to respect data type
hist1 = imhist(im); %// Compute histograms
hist2 = imhist(ref);
cdf1 = cumsum(hist1) / numel(im); %// Compute CDFs
cdf2 = cumsum(hist2) / numel(ref);

%// Compute the mapping
for idx = 1 : 256
    [~,ind] = min(abs(cdf1(idx) - cdf2));
    M(idx) = ind-1;
end

%// Now apply the mapping to get first image to make
%// the image look like the distribution of the second image
out = M(double(im)+1);

figure;
subplot(2,2,1),imshow(im); title('Main image');
subplot(2,2,2),imshow(ref); title('Reference image');
subplot(2,2,3),imshow(out); title('Result');
