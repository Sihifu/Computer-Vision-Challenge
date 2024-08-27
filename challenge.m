%% Computer Vision Challenge 2020 challenge.m

%% Start timer here
tic
config;
% variable that decides how many frames to pass e.g. only every m'th mask
% will be calculated
m=3;
%% Generate Movie
if store
    v = VideoWriter(fullfile(dest,'output_test.avi'),'Uncompressed AVI');
    open(v)
end


while ir.loop ~= 1
    for j=1:m
        % only calculate mask for every second frame
        % Get next image tensors
        [left ,right, ~] = next(ir);
        if j==1
            % Generate binary mask
            [mask] = segmentation(left,right);
        end
        % Render new frame
        frame=ir.left(:,:,1:3);
        result=render(frame, mask, bg, redner_mode);
        
        %% Write Movie to Disk
        if store
            % save all the frames as output.avi 
            writeVideo(v, result);
        end
        if ir.loop==1
            break;
        end
    end
end


if store
    %close v
    close(v);
end
%% Stop timer here
elapsed_time=toc
