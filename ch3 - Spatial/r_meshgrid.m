clear; 

a = [1,2,3]; 
b = [5,6,7,8,9];

% using for loop possible but will take way too long!

[mat1,mat2] = meshgrid(a,b); % size(a) specifies # of cols, size(b) specifies # rows

res = mat1 + mat2;

