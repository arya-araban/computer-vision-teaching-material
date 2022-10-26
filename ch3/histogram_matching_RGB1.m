%RGB HISTOGRAM MATCHING 
%by performing histogram matching on each R,G,B channel seperately.
%same as built-in function imhistmatch(im1,im2)!
clear; 

im1 = imread('..\Images\2\hm_main.jpg');
im2 = imread('..\Images\2\hm_ref.jpg');
%im1 = imread('..\Images\2\box1.png');
%im2 = imread('..\Images\2\box2.png');
out = uint8(zeros(size(im1)));
for i = 1:3
    M = zeros(256,1,'uint8'); %// Store mapping - Cast to uint8 to respect data type
    hist1 = imhist(im1(:,:,i)); %// Compute histograms
    hist2 = imhist(im2(:,:,i));
    cdf1 = cumsum(hist1) / numel(im1); %// Compute CDFs
    cdf2 = cumsum(hist2) / numel(im2);

    %// Compute the mapping
    for idx = 1 : 256
        [~,ind] = min(abs(cdf1(idx) - cdf2));
        M(idx) = ind-1;
    end

    %// Now apply the mapping to get first image to make
    %// the image look like the distribution of the second image
    out(:,:,i) = M(double(im1(:,:,i))+1);
end
figure;
subplot(2,2,1),imshow(im1); title('Main image');
subplot(2,2,2),imshow(im2); title('Reference image');
subplot(2,2,3),imshow(out); title('Result');
