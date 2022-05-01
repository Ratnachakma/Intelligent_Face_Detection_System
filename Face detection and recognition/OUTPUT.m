clear all
clc
close all




reqToolboxes = {'Computer Vision System Toolbox', 'Image Processing Toolbox'};
if( ~checkToolboxes(reqToolboxes) )
 error('detectFaceParts requires: Computer Vision System Toolbox and Image Processing Toolbox. Please install these toolboxes.');
end


% TestDatabasePath = uigetdir( 'Select test database path');

% im = imread(TestImage);




img = imread('TestDatabase\1.jpg');

detector = buildDetector();
[bbox bbimg faces bbfaces] = detectFaceParts(detector,img,2);
figure; imshow(img);
title('Test Image');
figure;imshow(bbimg);
title('Facial Parts Detection')
for i=1:size(bbfaces,1)
 figure;imshow(bbfaces{i}); 
 title('Cropping')
end
hold off
% Please uncoment to run demonstration of detectRotFaceParts
%{
 img = imrotate(img,180);
 detector = buildDetector(2,2);
 [fp bbimg faces bbfaces] = detectRotFaceParts(detector,img,15,2);

 figure;imshow(bbimg);
 for i=1:size(bbfaces,1)
  figure;imshow(bbfaces{i});
 end
%}



% A sample script, which shows the usage of functions, included in
% PCA-based face recognition system (Eigenface method)
%
% See also: CREATEDATABASE, EIGENFACECORE, RECOGNITION







TrainDatabasePath = uigetdir( 'Select training database path' );
TestDatabasePath = uigetdir( 'Select test database path');

prompt = {'Enter test image name (a number between 1 to 41):'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines= 1;
def = {'1'};

TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.jpg');
im = imread(TestImage);

T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);
OutputName = Recognition(TestImage, m, A, Eigenfaces);

SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);


% subplot(2,1,1);
% imshow(im);
% title('Test Image');


figure,imshow(SelectedImage);
title('Result by PCA');

str = strcat('Recognized image is : '  ,OutputName);
disp(str)








