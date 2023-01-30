clear;

%Read an Image
Img = imread('..\Images\2\Cameraman.bmp');
A = imnoise(Img,'Gaussian');
%Image with noise
figure,imshow(A);

I = double(A);

%Design the Gaussian Kernel
%Standard Deviation
sigma = 5; %if you want to increase sigma also increase size
%Window size
sz = 10; %note: size 4 means filter between [-4:4] on bath axis'
[x,y]=meshgrid(-sz:sz, -sz:sz);

Exp_comp = -(x.^2+y.^2)/(2*sigma*sigma);
Kernel= exp(Exp_comp)/(2*pi*sigma*sigma);


Output = conv2(I,Kernel,'same');

%Image after Gaussian blur
Output = uint8(Output);
figure,imshow(Output);
