% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==
% % Function which performs pixel-wise operations on a image.
% % INPUT: ops -- Array specifying the operations to perform on image
% % OUTPUT: b -- Image after applying the pixel-wise operations
% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==

function b = pointProcessing(ops)
    a = imread('..\Images\1\Barbara.bmp');
    b = a;
    
    for op = 1:length(ops) 
        
        if strcmp(ops{op},'invert')
            b=255-b;

        elseif strcmp(ops{op},'darken')
                b = b - 128;
                
        elseif strcmp(ops{op},'lighten')
                b = b + 128;

        elseif strcmp(ops{op},'rcontrast')
                b = b * 2;  

        elseif strcmp(ops{op},'lcontrast')
                b = b / 2;    
        end
 
    end 
    
    subplot(1,2,1); imshow(a); title 'Original Image'
    subplot(1,2,2); imshow(b); title 'Modified Image'  
end
