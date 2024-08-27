function [fgmask_filtered] = filter_mask_with_gaussianfilter(fgmask,sigma,threshold)
% Apply gaussian filter for mask and round to 1 or 0 depending on the
% threshold
% returns filtered gaussian mask (binary matrix)
m=imgaussfilt(double(fgmask),sigma);
fgmask_filtered=m;
fgmask_filtered(m<threshold)=0;
fgmask_filtered(m>=threshold)=1;
fgmask_filtered=logical(fgmask_filtered);
end

