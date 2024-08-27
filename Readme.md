# CV Group 25

- If not installed already, please install the Computer Vision Toolbox for MATLAB: [MathWorks Computer Vision Toolbox](https://www.mathworks.com/products/computer-vision.html).

## GUI Instructions

- The log provides you with instructions throughout the process.

### Steps to Use the GUI:

1. **Start GUI**:  
   Run `start_gui` in the Command Window to start the GUI.
   
2. **Import Button**:  
   Import a video for foreground segmentation.
   
3. **Mode**:  
   Select the mode for rendering.
   
4. **Select Mode Background**:  
   Choose the mode, either image or video.
   
5. **Select Background**:  
   Choose the background.
   
6. **Starting Frame**:  
   Select the first frame from which the segmentation process should start.
   
7. **Export**:  
   Export the rendered video to a path of your choice.
   
8. **Run**:  
   Execute the segmentation and rendering process.
   
9. **After Segmentation**:  
   A video player with the original and rendered video will be opened once the segmentation process is complete.

## Separate Function Instructions

If you need to start functions separately, note the following:

### 1. Class `ImageReader`

- **Create an Object**:  
  `ir = ImageReader(src, L, R, start, N);`  
  This creates an object to read videos and images where:
  - `src`: Path to the source.
  - `L` and `R`: Selected cameras (L can be {1,2} and R can be {2,3}). Do not choose the same value for `R` and `L`.
  - `start`: The starting frame (positive integer), e.g., the first frame to be read.
  - `N`: Number of successive frames.

- **Load Next Frame**:  
  `[left, right, loop] = next(ir);`  
  Method to load the next frame.

### 2. Function `segmentation`

- **Usage**:  
  `mask = segmentation(left, right);`  
  This function iterates through the image tensors `left` and `right` (both are 3D arrays with dimensions: `pixelwidth × pixelheight × (number of frames) · 3`), and returns the binary foreground mask of the first frame of `left` as `mask`.

### 3. Function `render`

- **Usage**:  
  `[result] = render(frame, mask, bg, render_mode);`  
  This function takes the following inputs:
  - `frame`: A 3D `uint8` RGB matrix.
  - `mask`: A binary mask matching the frame.
  - `bg`: A background image matrix (also RGB).
  - `render_mode`: A string that can be one of the following: `'foreground'`, `'background'`, `'overlay'`, `'substitute'`.

- **Functionality**:  
  The function renders the frame according to the `render_mode`, `mask`, and `bg`.
