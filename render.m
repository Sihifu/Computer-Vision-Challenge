function [result] = render(frame,mask,bg,render_mode)
  % The function render 
  %
  %defining the input 
  mask=repmat(mask,[1,1,3]);
  result = [];
  switch render_mode
      case "foreground"
          result = render_foreground(frame,mask);
      case "background"
          result = render_background(frame, mask);
      case "overlay"
          result = render_overlay(frame, mask);
      case "substitute"
          result = render_substitute (frame, mask,bg);
         
  end
  
  
end
function [result] = render_foreground(frame, mask)
frame_foreground=frame;
frame_foreground(~mask) = 0;
result=frame_foreground;
end
function [result]= render_background (frame, mask)
frame_background= frame;
frame_background(mask)=0;
result= frame_background;
end

function [result]=render_overlay(frame, mask)
background=render_background (frame, mask);
%background.AlphaData=0.5;
foreground=render_foreground(frame, mask);
%foreground.AlphaData=0.7;
result=imfuse(background,foreground,'falsecolor','Scaling','independent', 'ColorChannels', [1 2 0]);
end

function [result]= render_substitute(frame, mask,bg)

bg=imresize(bg,[size(frame,1) size(frame,2)]);
frame_substitute=render_foreground(frame,mask);
background=render_background(bg,mask);
frame_substitute_new=frame_substitute+background;
result=frame_substitute_new;
end

