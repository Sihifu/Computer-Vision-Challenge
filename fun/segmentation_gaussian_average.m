function [fgmask1, fgmask2] = segmentation_gaussian_average(left,right)
% Segmentation function using gaussian average
%% Segmentation for left
% extract image tensor of left
left=double(left);
% extract number of available images in left
N=size(left,3)/3;
% calculate Intensity matrix of last frame
I=vecnorm(left(:,:,end-2:end),2,3);
% initialize variance matrix
sigma=5*ones(size(I));
% initialize distance matrix
d=zeros(size(I));
% initialize mean matrix
mu=I;
% initialize udate/learning rate
rho=0.01;
% intialize threshhold for classification
k=2.5;
for i=N-1:-1:2
    % iterate through frames in a backward manner, starting from the last
    % frame until the second frame
    % calculate Intensity matrix of current frame
    I=vecnorm(left(:,:,3*i-2:3*i),2,3);
    % create the background mask for current frame/ classify the pixels
    bgmask=abs((I-mu)./(sigma))<=k;
    % update mean and variance matrix
    mu(bgmask)=rho*I(bgmask)+(1-rho)*mu(bgmask);
    d(bgmask)=abs(I(bgmask)-mu(bgmask));
    sigma(bgmask)=sqrt(rho*d(bgmask).^2 + (1-rho)*sigma(bgmask).^2);
end
% calculate Intensity matrix of first frame
I=vecnorm(left(:,:,1:3),2,3);
% classify the pixels
fgmask1=abs((I-mu)./(sigma))>k;

%% Segmentation for right
% extract image tensor of right
right=double(right);
% extract number of available images in left
N=size(left,3)/3;
% calculate Intensity matrix of last frame
I=vecnorm(left(:,:,end-2:end),2,3);
% initialize variance matrix
sigma=5*ones(size(I));
% initialize distance matrix
d=zeros(size(I));
% initialize mean matrix
mu=I;
% initialize udate/learning rate
rho=0.01;
% intialize threshhold for classification
k=2.5;
for i=N-1:-1:2
    % iterate through frames in a backward manner, starting from the last
    % frame until the second frame
    % calculate Intensity matrix of current frame
    I=vecnorm(left(:,:,3*i-2:3*i),2,3);
    % create the background mask for current frame/ classify the pixels
    bgmask=abs((I-mu)./(sigma))<=k;
    % update mean and variance matrix
    mu(bgmask)=rho*I(bgmask)+(1-rho)*mu(bgmask);
    d(bgmask)=abs(I(bgmask)-mu(bgmask));
    sigma(bgmask)=sqrt(rho*d(bgmask).^2 + (1-rho)*sigma(bgmask).^2);
end
% calculate Intensity matrix of first frame
I=vecnorm(right(:,:,1:3),2,3);
% classify the pixels
fgmask2=abs((I-mu)./(sigma))>k;
end

