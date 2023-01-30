%% Template Matching using Image Pyramids
% This tool will find a template in a search image
% using 2 image pyramids. A Gaussian Blur kernel is applied
% after subsampling the search image and template.

% SRD - Algorithm uses only 2 Image pyramids. 
%       To do: Further modularize this script. Either allow the user
%       specify how many image pyramids to use or make a 'smart' version
%       of the tool to determine based upon the search image size how
%       many image pyramids to use. 
%       This tool does not use for loops to search the image but uses 
%       MATLAB intrinsic properties. 
%
%% PRE CODE
clear all;
close all; 
clc;

%% Image Load

% load image
figure;

I = imread("..\Images\6\template_match\WaldoBeach.jpg");
temp = imread("..\Images\6\template_match\Waldo.jpg");

subplot(1,2,1);imshow(I); title("image");
subplot(1,2,2);imshow(temp); title("template");
% get grayscale values

g=rgb2gray(I);

gtemp=rgb2gray(temp);

% MATLAB reads in image as UINT8, convert to double so sum of differences
% can be negative
g=im2double(g);
gtemp=im2double(gtemp);

%% Subsample image

% First sub-sample

[x,y]=meshgrid(1:2:length(g), 1:2:length(g(:,1)));

gprime = g(y(:,1), x(1,:));

gprimeB = GaussianBlur(gprime, 3, 1);

gtemp2=gtemp;

[xg,yg] = size(gtemp2);

[xt,yt]=meshgrid(1:2:xg, 1:2:yg);

gprimet = gtemp2(xt(1,:), yt(:,1));

gprimetB = GaussianBlur(gprimet, 3, 1);

 
% 2nd sub-sample

[x,y]=meshgrid(1:2:length(gprimeB), 1:2:length(gprimeB(:,1)));

gprime2 = gprimeB(y(:,1), x(1,:));

gprimeB2 = GaussianBlur(gprime2, 3, 1);

[xg,yg] = size(gprimetB);

[xt,yt]=meshgrid(1:2:xg, 1:2:yg);

gprimet2 = gprimetB(xt(1,:), yt(:,1));

gprimetB2 = GaussianBlur(gprimet2, 3, 1);


%% Template Matching Algorithm

% Notes:

% Take Sum of Absolute Differences (SAD)

%

% Call template 'temp' for now

%

% We will searching the nth image pyramid first.

% When correlation to template is found determine a

% search area to the original search image using that

% information

%

% So now the search area with the lowest SAD score is known

% and the respective coordinates of the search image are known

% Need to use these coordinates and provide a search area for the

% original image.
%%%

% Get dimensions
tic
[gx,gy] = size(gprimeB2);

[dimx, dimy] = size(gprimetB2);

% threshold
low = 100;

% Search Space < this should be the image pyramid space >

for n=1:(gx-dimx)

    for m=1:(gy-dimy)   

        %Template Space

        bbb=gprimeB2(n:dimx+n-1,m:dimy+m-1);

        totb=abs(bbb-gprimetB2);

        tot=sum(totb(:));

        SAD(n,m) = tot;

       if (SAD(n,m) < low) % search space has lowest SAD score so far

           low = SAD(n,m);

           coordinate_x = n; % record center pixel x value on search space

           coordinate_y = m; % '                 ' y '                    '

       end
    end
end

% 2 Image pyramids = factor of 4:
% Apply margin of 100 pixels (should modularize this)

startx = coordinate_x*4-100;

endx = coordinate_x*4+100;

starty = coordinate_y*4-100;

endy = coordinate_y*4+100;

if min(startx) < 0

    startx = 1;

end

 
if min(starty) < 0

    starty = 1;

end

 
if max(endx) > length(g(1,:))

    endx = length(g(1,:));

end

 
if max(endy) > length(g(:,1))

    endy = length(g(:,1));

end

 
searchx = startx:1:endx;

searchy = starty:1:endy;

[dimx, dimy] = size(gtemp);

% Search Space < this should be the image pyramid space >

for n=1:length(searchx)

    for m=1:length(searchy)   

        %Template Space

        bbb=g(searchx(n):dimx+searchx(n)-1,searchy(m):dimy+searchy(m)-1);

        totb=abs(bbb-gtemp);

        tot=sum(totb(:));

        SAD(n,m) = tot;

       if (SAD(n,m) < low) % search space has lowest SAD score so far

           low = SAD(n,m);

           coordinate_x = searchx(n); % record center pixel x value on search space

           coordinate_y = searchy(m); % '                 ' y '                    '

       end

    end

end
toc

% Get template dimensions
[dtempx, dtempy] = size(gtemp);

% Show original color image with template box
figure, imshow(I);
hold on;
rectangle('Position', [coordinate_y coordinate_x dtempy dtempx], 'LineWidth', 2);