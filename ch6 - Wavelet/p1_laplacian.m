clear;
img = rgb2gray(imread('..\Images\6\Lena.bmp'));
level = 5;
pyr = cell(1,level);
% LAPLACIAN PYRAMID CREATION
cur_img = img;
for i=1:level-1
    md_img = impyramid(cur_img,'reduce');
    upscaled = pixel_replication(md_img);
    
    lp = cur_img - upscaled;
    
    pyr{i} = lp;
    
    cur_img=md_img;
   
    
    figure;
    imshow(lp);
end
pyr{level} = md_img;
figure;
imshow(pyr{level});



% LAPLACIAN PYRAMID RECONSTRUCION - HOMEWORK :)








