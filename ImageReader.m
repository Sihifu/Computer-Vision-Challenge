classdef ImageReader < handle
  % class ImageReader, 
  % which can play 2 of the 3 videostreams
  % from a directory of a scene in a loop

    
   properties
   % define properties
     L;
     R;
     srcL;
     srcR;
     start;
     N;
     L_jpgFiles;
     R_jpgFiles;
     left;
     right;
     number_of_jpgs;
     loop;
   end
    
   methods
        
      function ir = ImageReader(src, varargin)
 
        % initialize default values for start and N, define validation
        % function for inputs
        default_start=0;
        check_start=@(x) isnumeric(x) && mod(x,1)==0 && x>=0;

        default_N=1;
        check_N=@(x) isnumeric(x) && mod(x,1)==0 && x>0;
        
        % create parser
        p=inputParser;
        addRequired(p,'L');
        addRequired(p,'R');
        addOptional(p,'start',default_start,check_start);
        addOptional(p,'N',default_N,check_N);
        
        % iterate through parser
        parse(p,varargin{:});
        L=p.Results.L;
        R=p.Results.R;
        start=p.Results.start;
        N=p.Results.N;

          
%           check if folder exists:
            if ~isfolder(src)
              errorMessage = sprintf('Error: The following folder does not exist:\n%s', src);
              uiwait(warndlg(errorMessage)); % blocks the programm untill a correct folder is provided
              return;
            end
            [~, name ]= fileparts(src);
           % Check the value of L-camera and update src
            switch L
                case {1,2}
                    srcL=strcat(src, filesep, name,'_C', int2str(L)); % update srcL
                otherwise
                   error_L = sprintf('Choose a correct value for L i.e. {1,2}!');
                   uiwait(warndlg(error_L));
                   return;
            end
            
            % Check the value of R-camera and update src
            switch R
                case {2,3}
                    if R==L
                         error_LR = sprintf('Either L or R is allowed to have the value 2!');
                         uiwait(warndlg(error_LR));
                         return;
                    else
                        srcR=strcat(src, filesep, name,'_C', int2str(R)); % update srcR
                    end
                otherwise
                   error_R = sprintf('choose a correct value for R i.e. {2,3}!');
                   uiwait(warndlg(error_R));
                   return;
            end
            
       % extend the path to the subfolders
       [~, nameL ]= fileparts(srcL); %variable nameL, last part of srcL
       [~, nameR ]= fileparts(srcR); %variable nameR, last part of srcR
       % create path for subfolders
       srcL1=strcat(srcL,filesep, nameL,'.1'); 
       srcL2=strcat(srcL,filesep, nameL,'.2');
       srcR1=strcat(srcR,filesep, nameR,'.1');
       srcR2=strcat(srcR,filesep, nameR,'.2');
       
        if (isfolder(srcL1) && isfolder(srcL2)) %check if both subfolders exist
            sprintf('%s and %s include two subfolders each.',nameL,nameR)
            Choice = ' Choose 1 or 2!'; % make user choose in coomand window 
            C = input(Choice);
        %update srcL and srcR
            if C==1
            srcL=srcL1;
            srcR=srcR1;
            elseif C==2
            srcL=srcL2;
            srcR=srcR2;
            end
        elseif isfolder(srcL1)
            srcL=srcL1;
            srcR=srcR1;
        end
       
       imgL_name = fullfile(srcL, '*.jpg'); %path with .jpg extention
       ir.L_jpgFiles = dir(imgL_name); %list with photos' information 
                
       imgR_name = fullfile(srcR, '*.jpg'); 
       ir.R_jpgFiles = dir(imgR_name);
       
       ir.number_of_jpgs=numel(ir.L_jpgFiles);
       
       if start > ir.number_of_jpgs - 1
              errorMessage = sprintf('The value start exceeds the the number of frames');
              uiwait(warndlg(errorMessage)); % blocks the programm untill a correct folder is provided
              return;
       end
       
       %save as properties
       ir.L=L;
       ir.R=R;
       ir.srcL=srcL;
       ir.srcR=srcR;
       ir.start=start;
       ir.N=N;
       ir.loop=0;
       
    
      end
      
      function [left ,right, loop] = next(ir)
           
            
            if ir.loop==1
                % looped, and therefore reset start=1;
                ir.start=1;
            else
                % not in loop iterate start
                ir.start=ir.start+1;
            end
            if ir.number_of_jpgs<ir.N+ir.start
                % not enough follower set loop to 1 and, k_end=remaining
                % follower
                k_end=ir.number_of_jpgs-ir.start;
                loop=1;
            else
                % enough follower available
                k_end=ir.N;
                loop=0;
            end
            
            % initialize l and r and load the first images in l and r
            l1=imread(fullfile(ir.srcL,ir.L_jpgFiles(ir.start).name));
            r1=imread(fullfile(ir.srcR,ir.R_jpgFiles(ir.start).name));
            left=zeros(size(l1,1),size(l1,2),3*(k_end+1));
            right=zeros(size(r1,1),size(r1,2),3*(k_end+1));
            left(:,:,1:3)=l1;
            right(:,:,1:3)=r1;
            for i=1:k_end
                % load only the following images in l and r
                l=imread(fullfile(ir.srcL,ir.L_jpgFiles(ir.start+i).name));
                r=imread(fullfile(ir.srcR,ir.R_jpgFiles(ir.start+i).name));
                left(:,:,3*i+1:3*i+3)=l;
                right(:,:,3*i+1:3*i+3)=r;
            end
            
            % return the values of left and right
            left=uint8(left);
            right=uint8(right);
            ir.left=left;
            ir.right=right;
            ir.loop=loop;
      end
   end
end

