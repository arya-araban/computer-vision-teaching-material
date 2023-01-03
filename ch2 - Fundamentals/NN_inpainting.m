% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==
% % Implementation of Nearest Neighbour inpainting (interpolation) 
% % AKA Pixel Replication
% % ~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==~==

clear; 

og_image = imread('..\Images\1\Elaine.bmp');

in= imread('..\Images\1\Elaine_Downsampled.bmp');

in_row_size = size(in,1);
in_col_size = size(in,2);

% DEFINE THE RESAMPLE SIZE
out_row_size =  size(og_image,1);
out_col_size = size(og_image,2);



%FIND THE RATIO OF THE NEW SIZE BY OLD SIZE
rowRatio = out_row_size/in_row_size;
colRatio = out_col_size/in_col_size;


%OBTAIN THE INTERPOLATED POSITIONS
IR = ceil( [1:(in_row_size*rowRatio)]./(rowRatio) );
IC = ceil( [1:(in_col_size*colRatio)]./(colRatio) );


%ROW_WISE INTERPOLATION
B = in(:,IR); %number of cols increase 


%COLUMN-WISE INTERPOLATION
B = B(IC,:); %number of rows increase 



figure;

%subplot(1,2,1),imshow(og_image); title ('ORIGINAL IMAGE'); axis([0,out_row_size,0,out_col_size]);axis on;
subplot(1,2,1),imshow(in);title('BEFORE INTERPOLATION'); axis([0,out_row_size,0,out_col_size]);axis on;

subplot(1,2,2),imshow(B);title('AFTER INTERPOLATION');  axis([0,out_row_size,0,out_col_size]);axis on;
