% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==
% % Showing how considering 'n' bits of each pixel in an image and then perform
% % quantiziation will effect the quality of the image
% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==

clear

in = imread('..\Images\1\Barbara.bmp');
in = rgb2gray(in);

% we convert to double so we can do math on the original image
in = double(in); 

%Doing the main computations for quantization
figure(1)
for b = 1:8
    
    q = 256/(2^b);
    v = floor(in./q);
    v = v.*q;
    
    v = uint8(v); 
    
    subplot(3,3,b)
    imshow(v);
    title(strcat('#bits = ', num2str(b)))
end



