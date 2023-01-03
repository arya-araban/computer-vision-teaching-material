clc, clear all, close all;

vid_path = 'visiontraffic.avi'; %'atrium.mp4';
implay(vid_path);

vidReader = VideoReader(vid_path);
vid = read(vidReader);
frame1 = vid(:,:,:,315);
frame2 = vid(:,:,:,316);

subplot(1,2,1);imshow(frame1);title('first frame');
subplot(1,2,2);imshow(frame2);title('second frame');

frame = {frame1, frame2};

h = figure;
movegui(h);
hViewPanel = uipanel(h,'Position',[0 0 1 1],'Title','Plot of Optical Flow Vectors');
hPlot = axes(hViewPanel);

opticFlow =  opticalFlowHS; %opticalFlowLK('NoiseThreshold',0.025);
for i=1:2
    frameRGB = frame{i};
    frameGray = im2gray(frameRGB);  
    flow = estimateFlow(opticFlow,frameGray);
    imshow(frameRGB)
    hold on
    plot(flow,'DecimationFactor',[5 5],'ScaleFactor',60,'Parent',hPlot);
    hold off
end