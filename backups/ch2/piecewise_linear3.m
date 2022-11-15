filename = '..\Images\2\Cameraman.bmp';
I = imread(filename);
I = I + 64; %lower the contrast of image
[M,N,z] = size(I);
if(z>1)
  I=rgb2gray(I);
end
subplot(1,2,1);
imshow(I);
title('Original Image');

%Histogram
hist1=imhist(I);
subplot(1,2,2);
plot(hist1);
title('Histogram');
xlabel('Level');
ylabel('Number of Pixel');
%

%Linear Contrast Stretching
a=0;
b=255;
c=min(I(:));
d=max(I(:));
R=reshape(I,1,M*N);
lvl=1:b+1;
Pout= zeros(1,M*N);
for m=1:b+1
    indeks=find(lvl(m)==R);
    Pout(indeks)=(R(indeks)-c).*((b-a)/(d-c))+a;
end

Pout=uint8(reshape(Pout,M,N));
figure,
subplot(1,2,1);
imshow(Pout);
title('Image After Linear Contrast Stretching');

%Histogram
hist2=imhist(Pout);
subplot(1,2,2);
plot(hist2);
title('Histogram');
xlabel('Level');
ylabel('Number of Pixel');
%