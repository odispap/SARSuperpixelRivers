%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graph for superpixel method comparison
% SLIC
% LSC
% MISP
% MISP-GGD
%
% Oct 2019
% O. Pappas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



close all; 
clear all; 

% IMAGE LOAD
load('iceye_crops.mat');
img = img(:,:,5);
figure, imshow(img,[]);
title('Original SAR Image');


% MISP SUPERPIXEL SEGMENTATION
RegionSize = 20;
alfa = 1000000;
sMap = misp(img,RegionSize,alfa);
areaThresh = (RegionSize^2)/20;
connectivity = 8;
[supMap, Am] = cleanupregions(sMap, areaThresh, connectivity);
% VIEW SEGMENTATION MAP
boundMap = drawregionboundaries(supMap);
figure
imshow(imoverlay(img/255,boundMap,'r'));
title('MISP Superpixel Map');


% MISP-GGD SUPERPIXEL SEGMENTATION
RegionSize = 20;
alfa = 1000000;
maxiter = 25;
sMap = mod_misp_GGD(img,RegionSize,alfa,maxiter);
areaThresh = (RegionSize^2)/20;
connectivity = 8;
[supMap, Am] = cleanupregions(sMap, areaThresh, connectivity);
% VIEW SEGMENTATION MAP
boundMap = drawregionboundaries(supMap);
figure
imshow(imoverlay(img/255,boundMap,'r'));
title('MISP Generalised Gamma Superpixel Map');


% SLIC SUPERPIXEL SEGMENTATION
RegionSize = 20;
slic_K = ceil((300*300)/(RegionSize^2));
m = 20;
imgC(:,:,1) = img/255;
imgC(:,:,2) = img/255;
imgC(:,:,3) = img/255;
[sMap, Adjam, Sp] = slic(imgC, slic_K, m, 1, 'median');
areaThresh = (RegionSize^2)/20;
connectivity = 8;
[supMap, Am] = cleanupregions(sMap, areaThresh, connectivity);
% VIEW SEGMENTATION MAP
boundMap = drawregionboundaries(supMap);
figure
imshow(imoverlay(img/255,boundMap,'r'));
title('SLIC Superpixel Map');


% LSC SUPERPIXEL SEGMENTATION
RegionSize = 20;
lsc_K = ceil((300*300)/(RegionSize^2));
gaus = fspecial('gaussian',3);
imgC(:,:,1) = img;
imgC(:,:,2) = img;
imgC(:,:,3) = img;
imgC = uint8(imgC);
I = imfilter(imgC,gaus);
ratio=0.075;
sMap=LSC_mex(I,lsc_K,ratio);
sMap = double(sMap);
% [Am, Al] = regionadjacency(sMap);
areaThresh = (RegionSize^2)/20;
connectivity = 8;
[supMap, Am] = cleanupregions(sMap, areaThresh, connectivity);
% VIEW SEGMENTATION MAP
boundMap = drawregionboundaries(supMap);
figure
imshow(imoverlay(img/255,boundMap,'r'));
title('LSC Superpixel Map');
