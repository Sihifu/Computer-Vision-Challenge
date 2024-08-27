function [mask] = segmentation(left, right)
% function that returns the foreground mask of the first frame of left
    % include fun directory in path
    path([pwd '/fun'],path);
    % initialize hyperparameters
    threshold_mean_approx=8;
    sigma_gaussian_filter=7;
    threshold_gaussian_filter=0.4;
    % extract the first frames of right and left and store them in I1 and I2
    I1=left(:,:,1:3);
    I2=right(:,:,1:3);
    % initialize foregroundmasks
    fgmask1=false(size(I1,1),size(I1,2),3);
    fgmask2=false(size(I2,1),size(I2,2),3);
    
    % calculate 3 foregroundmasks with different algorithms and store them
    % in fgmask
    [fgmask1(:,:,1),fgmask2(:,:,1)] = segmentation_gaussian_average(left,right);
    [fgmask1(:,:,2),fgmask2(:,:,2)] = segmentation_with_mean_approx(left,right,threshold_mean_approx);
    [fgmask1(:,:,3),fgmask2(:,:,3)] = segmentation_with_morphological_grad(left, right);
    % apply gaussian filter over masks
    for i=1:3
        [fgmask1(:,:,i)] = filter_mask_with_gaussianfilter(fgmask1(:,:,i),sigma_gaussian_filter,threshold_gaussian_filter);
        [fgmask2(:,:,i)] = filter_mask_with_gaussianfilter(fgmask2(:,:,i),sigma_gaussian_filter,threshold_gaussian_filter);
    end
    
    % classify background/foreground of left with majority vote
    fgmask1=sum(fgmask1,3);
    fgmask1(fgmask1<1.5)=0;
    fgmask1(fgmask1>1.5)=1;
    fgmask1=logical(fgmask1);
    
    % classify background/foreground of left with majority vote
    fgmask2=sum(fgmask2,3);
    fgmask2(fgmask2<1.5)=0;
    fgmask2(fgmask2>1.5)=1;
    fgmask2=logical(fgmask2);
    
    % apply gaussian filter over the fgmask1
    [mask] = filter_mask_with_gaussianfilter(fgmask1,sigma_gaussian_filter,threshold_gaussian_filter);
end
