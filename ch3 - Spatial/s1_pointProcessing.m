% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==
% % Function to perform various point operations on an image.
% % note that input should be an array containing one or more of: 
% % 'invert', 'darken', 'lighten', 'locntrast', 'rcontast'
% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==

function pointProcessing(ops)
    a = imread('..\Images\1\Barbara.bmp');
    b = a;
    
    for op = 1:length(ops) 
        
        if strcmp(ops{op},'invert')
            b=255-b;

        elseif strcmp(ops{op},'darken')
                b = b - 64;
                
        elseif strcmp(ops{op},'lighten')
                b = b + 64;

        elseif strcmp(ops{op},'rcontrast')
                b = b * 2;  

        elseif strcmp(ops{op},'lcontrast')
                b = b / 2;    
        end
 
    end 
    
   
    subplot(2,2,1); imshow(a); title 'Original Image'
    subplot(2,2,2); histogram(a, unique(a)); 
    
    subplot(2,2,3); imshow(b); title 'Modified Image'  
    subplot(2,2,4); histogram(b,unique(b)); 
end
