%% Computer Vision Challenge 2020 config.m
%% Generall Settings
% Group number:
 group_number = 25;

% Group members:
 members = {'Yosra Bahri', 'Hoang Giang Dang', 'Julia Kanzler','Madeleine Kaufmann','Yamen Mohisn'};

% Email-Address:
 mail = {'ga26koy@mytum.de', 'ga45bic@mytum.de', 'julia.kanzler@tum.de', 'madeleine.kaufmann@tum.de', 'yamen.mohisn@tum.de'};


%% Setup Image Reader
% Specify Scene Folder
 src = '../Segmentation/P1E_S1';

% Select Cameras
  L =1;
  R =2;

% Choose a start point
 start = 1135;

% Choose the number of succseeding frames
 N = 20;

ir = ImageReader(src, L, R, start, N);


%% Output Settings
% Output Path
dest = "";

% Load Virual Background
bg = imread("hintergrund.jpg");

% Select rendering mode
render_mode = "substitute";

% Store Output?
store = true;
