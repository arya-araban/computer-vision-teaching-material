function imgGamma = GammaMap(img,gamma)
    imgTemp = double(img); % Create temporary image of type double
    imgTemp = imgTemp * 1./255;      % Before mapping, scale the image: g = f*(1/255)
    imgTemp = imgTemp.^gamma; % Use the stretching formula
    imgGamma = imgTemp.*255;   % After mapping, scale the image back, f = g*255
    imgGamma = uint8(imgGamma); % Before returning the image, transform it to uint8
end
