function [fgmask1,fgmask2] = segmentation_with_mean_approx(left,right,threshold)
% calculate and returns the foregroundmasks for the first frame of 3D tensors
% left and right with the help of all frames available in left and right
%% calculate foregroundmask for left 
% return number of available frames in left and store them in N
N=size(left,3)/3;
% intialize background frame of left with zeros
background=zeros(size(left,1),size(left,2));
% background frame of left is the mean of all frames available in left
for i=1:N
    background=background+double(rgb2gray(left(:,:,3*i-2:3*i)));
end
% convert background to uint8
background=uint8(background/N);
% exctract first frame from left
I=left(:,:,1:3);
% convert the I to grayscale
I_gray=rgb2gray(I);
% binary foregroundmask of left is optained by backsubstraction with respect to given
% threshold
fgmask1=abs(double(I_gray)-double(background))>threshold;

%% calculate foregroundmask for right

% return number of available frames in right and store them in N
N=size(right,3)/3;
% intialize background frame of right with zeros
background=zeros(size(right,1),size(right,2));
% background frame of right is the mean of all frames available in left
for i=1:N
    background=background+double(rgb2gray(right(:,:,3*i-2:3*i)));
end
% convert background to uint8
background=uint8(background/N);
% exctract first frame from right
I=right(:,:,1:3);
% convert the I to grayscale
I_gray=rgb2gray(I);
% binary foregroundmask of right is optained by backsubstraction with respect to given
% threshold
fgmask2=abs(double(I_gray)-double(background))>threshold;

end

