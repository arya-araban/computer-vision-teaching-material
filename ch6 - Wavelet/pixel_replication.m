function output = pixel_replication(img)
[X,Y] = size(img);
%make sure output is 2* the size of the input
output = zeros(2*X,2*Y);
for x = 1:X 
    for y = 1:Y
        %first we find the top-left, and then find others in respect to it
        j = 2*(x-1) + 1; 
        i = 2*(y-1) + 1;         
        output(j,i) = img(x,y); %// Top-left
        output(j+1,i) = img(x,y); %// Bottom-left
        output(j,i+1) = img(x,y); %// Top-right
        output(j+1,i+1) = img(x,y); %// Bottom-right
    end
end
output = uint8(output);
end