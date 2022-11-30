function pyramid=GaussianPyramid(image, iternum)
    
    pyramid = cell(iternum, 1);
    pyramid{1} = image;
    
    for i = 2 : iternum
        pyramid{i} = impyramid(pyramid{i-1},'reduce');
    end
    