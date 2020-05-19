% Take ICEYE image, extract 10 crops of river area

clear all; 
close all; 

img = zeros(300,300,5);

% FULL
im = imread('S1B_IW_GRDH_1SDV_20191027T172331_20191027T172356_018664_0232C7_F9E0_Amplitude_VH', 'tiff');
img_master = im(:,:,1); % Keep 1st channel
img_master = img_master(1:900,1:1150);
figure,imshow(img_master,[]);
title('SAR SENTINEL-1 Image Master');


% CROP 1 
img(:,:,1) = img_master(1:300,1:300);
figure, imshow(img(:,:,1),[]);
title('Crop 1');

img(:,:,2) = img_master(150:449,330:629);
figure, imshow(img(:,:,2),[]);
title('Crop 2');

img(:,:,3) = img_master(320:619,460:759);
figure, imshow(img(:,:,3),[]);
title('Crop 3');

img(:,:,4) = img_master(390:689,700:999);
figure, imshow(img(:,:,4),[]);
title('Crop 4');

img(:,:,5) = img_master(500:799,800:1099);
figure, imshow(img(:,:,5),[]);
title('Crop 5');

save('sentinel_crops.mat');