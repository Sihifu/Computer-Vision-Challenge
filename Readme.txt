# CV Group 25
- if not installed already, please install computervision toolbox for matlab: https://www.mathworks.com/products/computer-vision.html

Gui - 	- The Log gives you instructions

	- 1. start_gui in Command window um die Gui zu starten 
	- 2. Import Button: importing a video for foreground segmentation
	- 3. Mode: select the Mode for rendering mode 
	- 4. Select Mode Background: Select the mode either image or video	
	- 5. Select Background: Select the Background 
	- 6. Starting Frame: Select the first Frame the segmentation has to start with 
	- 7. Export: export the rendered video to a path of your choice	
	- 8. Run: Runs the segmentation and rendering process
	- 9. After segmenation is processed: Videoplayer with original video and rendered video is opened
	

To start functions seperately beware of:

1- class ImageReader: 
	- ir = ImageReader(src, L, R, start, N); 	creates object to read videos and images
							src = path, 
							L {1,2}  and R {2,3} are selected cameras. Do not choose the same value for R and L.
							start = marks the staring frame, e.g. the first frame to be read (postive integer)   , N = numbers of successor frames
	- [left ,right, loop] = next(ir);		method, to load next frame
	
2- function mask = segmentation(left, right)		
                            iterates through image tensor left und right, left and right are 3D, each dimension is
							pixelwidth × pixelheight × (number of frames) · 3.
							function returns the binary foreground mask of the first frame of left as mask.
							
3- function [result] = render(frame,mask,bg,render_mode)
                        frame - is expected to be 3D uint8, thus a rgb matrix
                        mask - a binary mask matching the frame
                        bg - background image matrix (also rgb)
                        render_mode - expects one the following strings: 'foreground','background','overlay','substitute'
                        function renders frame according to render_mode,mask and bg

					