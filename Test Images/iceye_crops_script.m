% Take ICEYE image, extract 10 crops of river area

clear all; 
close all; 

img = zeros(300,300,10);

% FULL
im = imread('ICEYE_ds694_fr1_slc_ML_RDC_Intensity_VV_2', 'tiff');
img_master = im(:,:,1); % Keep 1st channel
% img = img(1:960,1:1728); % Crop dims to multiple of 2^J, automate in future
figure,imshow(img_master,[]);
title('SAR Image ICEYE detail');

% CROP 1 
img(:,:,1) = img_master(1:300,750:1049);
figure, imshow(img(:,:,1),[]);
title('Crop 1');

% CROP 2 
img(:,:,2) = img_master(50:349,920:1219);
figure, imshow(img(:,:,2),[]);
title('Crop 2');

% CROP 3 
img(:,:,3) = img_master(350:649,1:300);
figure, imshow(img(:,:,3),[]);
title('Crop 3');

% CROP 4 
img(:,:,4) = img_master(300:599,300:599);
figure, imshow(img(:,:,4),[]);
title('Crop 4');

% CROP 5 
img(:,:,5) = img_master(400:699,600:899);
figure, imshow(img(:,:,5),[]);
title('Crop 5');

% CROP 6 
img(:,:,6) = img_master(150:449,700:999);
figure, imshow(img(:,:,6),[]);
title('Crop 6');

% CROP 7 
img(:,:,7) = img_master(650:949, 950:1249);
figure, imshow(img(:,:,7),[]);
title('Crop 7');

% CROP 8 
img(:,:,8) = img_master(550:849, 1150:1449);
figure, imshow(img(:,:,8),[]);
title('Crop 8');

% CROP 9 
img(:,:,9) = img_master(150:449, 1150:1449);
figure, imshow(img(:,:,9),[]);
title('Crop 9');

% CROP 10
img(:,:,10) = img_master(450:749, 1350:1649);
figure, imshow(img(:,:,10),[]);
title('Crop 10');

save('iceye_crops.mat');