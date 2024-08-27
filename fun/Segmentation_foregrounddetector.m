function [fgmask1, fgmask2] = Segmentation_foregrounddetector(left,right)
% calculate and returns the foregroundmasks for the first frame of 3D tensors
% left and right with the help of all frames available in left and right
%% calculate foregroundmask of left with Foregrounddetector of vision
% return number of available frames and left in store them in N
N=size(left,3)/3;
% initialize Foregrounddetector object
detector = vision.ForegroundDetector('NumTrainingFrames', N);
% resphape left tensor in a 4D tensor for easier extraction of frames
left_seq=reshape(left,[size(left,1),size(left,2),3,N]);
% iterate through the frames in a 'backward' manner to learn the background
% model and return binary foregroundmask
for i=N:-1:1
    fgmask1=detector(left_seq(:,:,:,i));
end
%% calculate foregroundmask for right with the same algorithm for left
% return number of available frames in right and store them in N
N=size(left,3)/3;
% initialize Foregrounddetector object
detector = vision.ForegroundDetector('NumTrainingFrames', N);
% resphape right tensor in a 4D tensor for easier extraction of frames
right_seq=reshape(right,[size(right,1),size(right,2),3,N]);
% iterate through the frames in a 'backward' manner to learn the background
% model and return binary foregroundmask
for i=N:-1:1
    fgmask2=detector(right_seq(:,:,:,i));
end
end

