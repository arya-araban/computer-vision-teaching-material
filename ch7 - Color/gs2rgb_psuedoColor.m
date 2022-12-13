clc; clear all; close all;
im = imread('threads.png');
figure; imshow(im);
x = double(im);
c1 = 0.9; c2 = 0.3; c3 = 0.7; c4 = 0.9;
rx = x .* (1 + c3*sin(pi*x./255) + c4*(1-cos(2*pi*x./255)));
gx = x .* (1 + c1*sin(pi*x./255) + c2*(1-cos(2*pi*x./255)));
bx = 2*x + rx - gx;
rgb = mat2gray(cat(3, rx, gx, bx));
figure; imshow(rgb)