clear;
%wavelet packet decomposotion
img = rgb2gray(imread('..\Images\6\Lena.bmp'));

t = wpdec2(img,2,"haar");

plot(t);