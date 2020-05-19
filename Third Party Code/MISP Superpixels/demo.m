% MATLAB implementation for Mixture-based Superpixel Segmentation
%
% This software is used to demo the mixture-based superpixel
% segmentation algorithm (MISP). The theoretical detailed of 
% the algorithm can be  found in the following paper:
% 
% Sertac Arisoy and Koray Kayabol, "Mixture-based superpixel 
% segmentation and classification of SAR images", 
% IEEE Geoscience and Remote Sensing Letters, vol.13, no. 11, 
% pp. 1721-1725, 2016.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2016, Sertac Arisoy, Koray Kayabol, % 
% <sarisoy@gtu.edu.tr>, <koray.kayabol@gtu.edu.tr>, %             
% All rights reserved               			    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;clear all;clc

disp('Mixture-based Superpixel Segmentation Demo');

load 'ros6300_3000.mat'

% RegionSize is the starting size of the superpixels.
% It arranges the number of superpixels.
RegionSize = 55;

% Default concentration parameter value
alfa = 1000000;

%Generate raw MISP superpixel
sMap = misp(S,RegionSize,alfa);


% As mentioned in the paper, the small connected 
% components are merged adjacent neighbors to get 
% final superpixel map

areaThresh = (RegionSize^2)/20;
connectivity = 8;
[supMap, Am] = cleanupregions(sMap, areaThresh, connectivity);


% Find superpixel boundaries
boundMap = drawregionboundaries(supMap);
[row,col] = find(boundMap == 1);


figure
imagesc(S)
colormap(gray)
axis off
hold on
h = plot(col, row, 'r.');
set(h, 'MarkerSize', 4.6, 'MarkerFaceColor', 'r');
title('Final MISP Superpixel Map');


