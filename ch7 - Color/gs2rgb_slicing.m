clear, clc, close all;

figure; imshow('moon.tif');

hexMap = {'C0C0C0', '808080', '404040', '000000', 'FF99CC', '9999FF', '3333FF', '000099', '3399FF', '0066CC', '99CCFF', '66B2FF', '66FFFF', '006633', '00CC66', '66FF66', '00FF00', '009900', 'FFFF99', 'FFFF00', 'CCCC00', 'FFB266', 'CC6600', '994C00', 'FF9999', 'FF0000', 'CC0000', '990000'};
myColorMap = zeros(length(hexMap), 3); % Preallocate
for k = 1 : length(hexMap)
	thisCell = hexMap{k};
	r = hex2dec(thisCell(1:2));
	g = hex2dec(thisCell(3:4));
	b = hex2dec(thisCell(5:6));
	myColorMap(k, :) = [r, g, b];
end
% Normalize to range 0-1
figure; imshow('moon.tif');
colormap(myColorMap / 255);
colorbar;