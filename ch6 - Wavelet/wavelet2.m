clear;

img = rgb2gray(imread('..\Images\6\Lena.bmp'));

decomp_level=5;

[c,s]=wavedec2(img,decomp_level,'haar'); %second arg is decomposition level
for i=1:decomp_level
    figure
    [H,V,D] = detcoef2('all',c,s,i);
    A = appcoef2(c,s,'haar',i);

    Vimg = wcodemat(V,255);
    Himg = wcodemat(H,255);
    Dimg = wcodemat(D,255);
    Aimg = wcodemat(A,255);

    subplot(2,2,1)
    imagesc(Aimg)
    colormap pink(255)
    title('Approximation Coef.')

    subplot(2,2,2)
    imagesc(Himg)
    title('Horizontal Detail Coef.')

    subplot(2,2,3)
    imagesc(Vimg)
    title('Vertical Detail Coef.')

    subplot(2,2,4)
    imagesc(Dimg)
    title('Diagonal Detail Coef.')

end


