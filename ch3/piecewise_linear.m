%Contrast streching using Piecewise linear transformation
%Slopes chosen are 0.5, 2 and 0.5
close all;
clear all;
clc;

%I=imread('Maulik.png');
I=imread('..\Images\2\Cameraman.bmp');
%I=rgb2gray(I);
I=im2double(I);
I = (I * 2) / max(I(:)); % brightening image to decrease contrast
I_str = 0;
[row,col] = size(I);

slp1 = 0.5; slp2 = 2; slp3 = 0.5;
LT = 50; % The lower threshold value
UT = 200; % The upper threshold value

grid on;
for i=1:row
    for j=1:col
        if I(i,j) <= LT 
            I_str(i,j)=slp1*I(i,j);    
            else if I(i,j) <= UT %less than or equal tUT
                I_str(i,j)=slp2*(I(i,j)-LT)+(slp1*LT);
             else
                I_str(i,j)=slp3*(I(i,j)-UT)+slp1*LT+slp2*(UT-LT);
            end
        end
    end
end
dd=[];
hold on;
dd(1:LT)=slp1*(0:LT-1);
dd(LT+1:UT)=slp2*((LT:UT-1)-LT)+0.5*LT;
dd(151:256)=(slp3*((150:255)-150))+(0.5*100)+(2*(150-100));
axis tight;
plot(dd);
hold on;
xlabel('Intensity in input image');ylabel('Intensity in output image');
title('Contrast-Stretch Transformation function');
figure
montage({I, I_str}, 'Size', [1 2]);
title('Original Image                        Contrast stretched Image');