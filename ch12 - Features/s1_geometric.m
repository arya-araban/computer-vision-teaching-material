close all;clear; clc;

whichIm = 4; %select the image
methd = 'BRISK';

im = rgb2gray(imread(['..\Images\7\Attack 1\',num2str(whichIm),'.bmp']));

reference_img = rgb2gray(imread('..\Images\7\reference.bmp'));
%reference_img = imcrop(reference_img,[350,350,232,100]); %crop for Q3

%Detect the feature points using the selected algorithm.
% SURF / BRISK / FAST / Harris
pointsA = feval(['detect', methd,'Features'],im);
pointsB = feval(['detect', methd,'Features'],reference_img);



% extract features finds descriptor using SURF algorithm 
[featuresA, pointsA] = extractFeatures(im, pointsA, method=methd);
[featuresB, pointsB] = extractFeatures(reference_img, pointsB, method=methd);

%%
% indexPairs = matchFeatures(featuresA, featuresB, 'MaxRatio',0.9);
Thresh_val = 13.0;
%%% 1: val= 9.0 --- 2: val=12.0 --- 3: val=13.0 --- 4: val=15.0
indexPairs = matchFeatures(featuresA, featuresB, 'MatchThreshold',Thresh_val);
matchedPointsA = pointsA(indexPairs(:,1),:); 
matchedPointsB = pointsB(indexPairs(:,2),:); 
A = matchedPointsA.Location; % location of the points on attack1 image
B = matchedPointsB.Location; % location of the points on reference image


x = A(:,1);
y = A(:,2);


M = fitgeotrans(A,B,'affine'); %putting the geometric transformation in M
original = rgb2gray(imread('..\Images\7\Original.bmp'));
converted_img=imwarp(im,M,'OutputView',imref2d(size(original))); %apply M to image in attack2

disp("MSE=" + immse(converted_img,original) + " --- " + "SSIM=" + ssim(converted_img,original) + " --- " + "MP= "+ size(A,1));

figure,imshow(im),hold on;
plot(x,y,'ys'),hold off;

figure,imshow(reference_img),hold on,x = B(:,1);y = B(:,2);plot(x,y,'ys');

figure,imshow(converted_img),hold on;x = B(:,1);y = B(:,2);plot(x,y,'ys');
