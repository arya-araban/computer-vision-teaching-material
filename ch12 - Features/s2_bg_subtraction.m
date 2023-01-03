clc, clear all, close all;

vid_path = 'atrium.mp4';

vid_obj = VideoReader(vid_path);
vid = read(vid_obj); % Gives 4d video object

refFrame = (vid(:,:,:,1));
imshow(refFrame);title('reference frame');

implay(vid_path);

totalNumFrames = vid_obj.NumberOfFrames;
thresholdParam = 0.1;%how sensitive you want the model to be to changes in pixel values/luminosity.


writerObj = VideoWriter('myVideo.avi');
writerObj.FrameRate = vid_obj.FrameRate;
% open the video writer
open(writerObj);

refFrame = rgb2gray(refFrame);
for i = (1:totalNumFrames)
    curFrame = (vid(:,:,:,i));
    curFrame_gray = rgb2gray(curFrame);
    diff_img = curFrame_gray - refFrame; % this is your 'c' matrix/variable
    binarisedMask =  im2uint8(imbinarize(diff_img, thresholdParam));%This matrix has the value 1 wherever the curFrame
                  %differs from refFrame and staisfies thresholdParam
                  %constraint. Thus motion detection is captured by this
                  %matrix
    imgt = horzcat(curFrame, repmat(binarisedMask,[1 1 3]));
    writeVideo(writerObj, imgt);
end
close(writerObj);
implay('myVideo.avi');