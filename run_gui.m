function [] = run_gui(src,start,mode,dst,background)
% runs if the run buttton is clicked in the gui
% set default values
m=3;
L =1;
R =2;
N = 10;
% create imagereader object
ir = ImageReader(src, L, R, start, N);
% open/create avi files
v1 = VideoWriter(fullfile(dst,'stereoinputstream.avi'),'Uncompressed AVI');
open(v1)
v2 = VideoWriter(fullfile(dst,'outputstream.avi'),'Uncompressed AVI');
open(v2)


if not(class(background)=="vision.VideoFileReader")
    % if render_modes is "substitute" the background of the substituted
    % background is an image
    bg=background;
    while ir.loop ~= 1
        for j=1:m
            % Get next image tensors
            [left ,right, ~] = next(ir);
            % Generate binary mask
            if j==1
                [mask] = segmentation(left,right);
            end
            % Render new frame
            frame=ir.left(:,:,1:3);
            result=render(frame, mask, bg, mode);
            %% Write Movie to Disk
            
            % save all the frames as outputstream.avi and 'stereoinputstream.avi'
            writeVideo(v1, frame);
            writeVideo(v2, result);
            if ir.loop==1
                break;
            end
        end
    end
else
    while ir.loop ~= 1
        for j=1:m
            % if render_modes is "substitute" the background the substituted
            % background is a video
            % get background image
            % check if video is alerady finished reset if the video if so
            if isDone(background)
                reset(background)
            end
            bg=background();
            % Get next image tensors
            [left ,right, ~] = next(ir);
            % Generate binary mask
            if j==1
                [mask] = segmentation(left,right);
            end
            % Render new frame
            frame=ir.left(:,:,1:3);
            result=render(frame, mask, bg, mode);
            %% Write Movie to Disk
            
            % save all the frames as outputstream.avi and 'stereoinputstream.avi'
            writeVideo(v1, frame);
            writeVideo(v2, result);
            if ir.loop==1
                break;
            end
        end
    end
end

% close v1 and v2
close(v1);
close(v2);
end
