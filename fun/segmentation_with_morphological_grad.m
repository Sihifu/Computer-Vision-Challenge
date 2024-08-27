function [fgmask1, fgmask2] = segmentation_with_morphological_grad(left, right)
% calculate and returns the foregroundmasks for the first frame of 3D tensors
% left and right with the help of all frames available in left and right
    % extract first frame from left
    img=left(:,:,1:3);
    % convert frame to grayscale
    gray = rgb2gray(img);
    % create strel object
    SE  = strel('Disk',1,4);
    morphologicalGradient = imsubtract(imdilate(gray, SE),imerode(gray, SE));
    fgmask1 = im2bw(morphologicalGradient,0.03);
    SE  = strel('Disk',3,4);
    fgmask1 = imclose(fgmask1, SE);
    fgmask1 = imfill(fgmask1,'holes');
    fgmask1 = bwareafilt(fgmask1,1);

    img=right(:,:,1:3);
    gray = rgb2gray(img);
    SE  = strel('Disk',1,4);
    morphologicalGradient = imsubtract(imdilate(gray, SE),imerode(gray, SE));
    fgmask2 = im2bw(morphologicalGradient,0.03);
    SE  = strel('Disk',3,4);
    fgmask2 = imclose(fgmask2, SE);
    fgmask2 = imfill(fgmask2,'holes');
    fgmask2 = bwareafilt(fgmask2,1);

end
