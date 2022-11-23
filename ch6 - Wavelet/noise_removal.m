clear;
img = rgb2gray(imread('C:\Users\Arya\Desktop\computer vision\HW\Images\6\Lena.bmp'));

nLevel = 3;  % Number of decompositions
th = 's'; %th = 'h'; %HARD OR SOFT THRESHOLD
thresh_val = 0.6745;

map = gray; %grayscale colormap
nColors = size(map, 1);  % Number of colors in colormap
cA = cell(1, nLevel);    % Approximation coefficients
cH = cell(1, nLevel);    % Horizontal detail coefficients
cV = cell(1, nLevel);    % Vertical detail coefficients
cD = cell(1, nLevel);    % Diagonal detail coefficients

noisy_image = imnoise(img,'gaussian',0,0.035);
startImage = noisy_image;
figure;imshow(noisy_image); imwrite(noisy_image, "5_noisyLena.jpg");
%CONSTRUCT
for iLevel = 1:nLevel,
  [cA{iLevel}, cH{iLevel}, cV{iLevel}, cD{iLevel}] = dwt2(startImage, 'haar');
  
  %APPLYING THRESHOLD TO ALL,EXCEPT THE LL
  cH{iLevel} = wthresh(cH{iLevel},th,(median(abs(cH{iLevel}(:)))/thresh_val));
  cV{iLevel} = wthresh(cV{iLevel},th,(median(abs(cV{iLevel}(:)))/thresh_val));
  cD{iLevel} = wthresh(cD{iLevel},th,(median(abs(cD{iLevel}(:)))/thresh_val));
  
  startImage = cA{iLevel};
end
% RECONSTRUCT
fullRecon = cA{nLevel};
for iLevel = nLevel:-1:1,
  fullRecon = idwt2(fullRecon, cH{iLevel}, cV{iLevel}, cD{iLevel}, 'haar');
end
fullRecon = uint8(fullRecon);

figure;imshow(fullRecon); imwrite(fullRecon, "5_Lena_HT_Reconstucted.jpg");

disp("MSE=" + immse(img,fullRecon) + " --- " + "PSNR=" + psnr(img,fullRecon));
