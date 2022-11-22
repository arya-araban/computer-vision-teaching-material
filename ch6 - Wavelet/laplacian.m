clear;
img = rgb2gray(imread('..\Images\6\Lena.bmp'));
level = 5;
pyr = cell(1,level);
% LAPLACIAN PYRAMID CREATION
old_img = img;
md_img = img;
for i=1:level-1
    md_img = impyramid(md_img,'reduce');
    upscaled = pixel_replication(md_img);
    lp = old_img - upscaled;
    old_img=md_img;
    pyr{i} = lp;
    
    figure;
    imshow(lp);
end
pyr{level} = md_img;
figure;
imshow(pyr{level});


clearvars -except pyr img level map

% LAPLACIAN PYRAMID RECONSTRUCION POSSIBLE -- HOMEWORK




