%%%%%%%%%%%%%%%%%%%%%%
% Connected component analysis.
% Load in river masks and attempt to remove false positives by filtering
% out based on regionprops. Try out a few possible options.
% 
% Nov. 2019
% O. Pappas
%%%%%%%%%%%%%%%%%%%%%%

% 
clear all
close all 


% Load Image 

img = imread('SENTINEL_fullareamask.png');
img = img(1:600,1:900);
figure, imshow(img,[]);
title('Original SAR River Mask');

% Connected Components 
bw = img/255;
CC = bwconncomp(bw);
regprops = regionprops(CC,'all');
component_count = CC.NumObjects;

% Select Biggest Component
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
new_map = img .* 0;
new_map(CC.PixelIdxList{idx}) = 1;
figure, imshow(new_map,[]);
title('Largest Connected Component');


% Eccentricity for measuring difference between a circle (eccec 0) and a
% line (eccec 1)
new_map = img .* 0;
for ii = 1:component_count
    ecc = regprops(ii).Eccentricity;
    if ecc > 0.9
        new_map(CC.PixelIdxList{ii}) = 1;
    end
end
figure, imshow(new_map,[]);
title('Connected Components with Eccentricity >0.9');

% Circularity 
new_map = img .*0;
for ii = 1:component_count
    circ = regprops(ii).Circularity;
    if circ < 0.1
        new_map(CC.PixelIdxList{ii}) = 1;
    end
end
figure, imshow(new_map,[]);
title('Connected Components with Circularity <0.1');

% Major Axis Length 
new_map = img .*0;
for ii = 1: component_count
    majax = regprops(ii).MajorAxisLength;
    if majax > 155
        new_map(CC.PixelIdxList{ii}) = 1;
    end
end
figure, imshow(new_map,[]);
title('Connected Components with Major Axis Lentgh > 155');
