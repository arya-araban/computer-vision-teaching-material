clear;
img = rgb2gray(imread('..\Images\6\Lena.bmp'));

nLevel = 3;  % Number of decompositions
map = gray; %grayscale colormap
nColors = size(map, 1);  % Number of colors in colormap

cA = cell(1, nLevel);    % Approximation coefficients
cH = cell(1, nLevel);    % Horizontal detail coefficients
cV = cell(1, nLevel);    % Vertical detail coefficients
cD = cell(1, nLevel);    % Diagonal detail coefficients

startImage = img;
%CONSTRUCT
for iLevel = 1:nLevel,
  [cA{iLevel}, cH{iLevel}, cV{iLevel}, cD{iLevel}] = dwt2(startImage, 'haar');
  startImage = cA{iLevel};
end

%cA{nLevel} = zeros(size(cA{nLevel}));
%for l = 1:nLevel
%    cV{l} = zeros(size(cV{l}));
%end

%CREATE TILED IMAGE
tiledImage = wcodemat(cA{nLevel}, nColors);

for iLevel = nLevel:-1:1,
  tiledImage = [tiledImage                    wcodemat(cH{iLevel}, nColors);
                wcodemat(cV{iLevel}, nColors) wcodemat(cD{iLevel}, nColors)];
end

figure;imshow(tiledImage, map);
%RECONSTRUCT ORIGINAL
fullRecon = cA{nLevel};
for iLevel = nLevel:-1:1,
  fullRecon = idwt2(fullRecon, cH{iLevel}, cV{iLevel}, cD{iLevel}, 'haar');
end
fullRecon = uint8(fullRecon);

figure;imshow(fullRecon);
disp("MSE=" + immse(img,fullRecon));
