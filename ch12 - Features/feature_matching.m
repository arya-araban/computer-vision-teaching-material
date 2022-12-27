close all;clear; clc;

methd = 'SURF';
% Find the corners.
I1 = imread('..\Images\7\matching\a1.jpg');
I2 = imread('..\Images\7\matching\a2.jpg');
I1_gray = rgb2gray(I1); I2_gray = rgb2gray(I2);

%detect the features
points1 = feval(['detect', methd,'Features'],I1_gray);
points2 = feval(['detect', methd,'Features'],I2_gray);
% Note that a SIFT implementation in Matlab 2022b 

% Extract the neighborhood features.
[features1,valid_points1] = extractFeatures(I1_gray,points1, method=methd);
[features2,valid_points2] = extractFeatures(I2_gray,points2, method=methd);

% Match the features.
indexPairs = matchFeatures(features1,features2);

% Retrieve the locations of the corresponding points for each image.
matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

% Visualize the corresponding points. You can see the effect of translation between the two images despite several erroneous matches.
figure; 
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,"montag");
