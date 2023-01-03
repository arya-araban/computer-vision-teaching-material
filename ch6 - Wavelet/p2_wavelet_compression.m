clear all, close all, clc

A = imread('..\Images\6\Lena.bmp');
B = rgb2gray(A);
imshow(B);
w_levels = 4;
[C,S] = wavedec2(B, w_levels,'haar');
Csort = sort(abs(C(:)));

counter=1;

% apply thresholding by only keeping highest 10% coeffs, and so on..
for keep = [.1 .05 .01 .005] 
    subplot(2,2,counter)
    thresh = Csort(floor((1-keep)*length(Csort)));
    ind = abs(C) > thresh;
    Cfilt = C.*ind; % applying thresholding
    
    Arecon = uint8(waverec2(Cfilt,S,'haar'));
    
    imshow(uint8(Arecon)); title (['keeping ' num2str(keep*100) '% of highest coeffs'])
    counter = counter + 1;
end
