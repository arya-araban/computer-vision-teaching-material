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



% LAPLACIAN PYRAMID RECONSTRUCION

cur_img = pyr{level};
for i = (level-1):-1:1
    cur_img = pixel_replication(cur_img) + pyr{i};
end
figure;
imshow(cur_img);




