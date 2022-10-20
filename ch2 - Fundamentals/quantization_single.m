clear

in = imread('..\Images\1\Barbara.bmp');
in = rgb2gray(in);

L = 2; %NUMBER OF LAYERS
% we convert to double so we can do math on the original image
in = double(in); 

%Doing the main computations for quantization
q = 256/L;
v = floor(in./q);
v = v.*q;

%return the image to their readable datatype
v = uint8(v); 

figure;
imshow(v);
title(strcat('L=', num2str(L)))
