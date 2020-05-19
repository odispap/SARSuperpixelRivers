%%%%%%%%%%%%%%%%%%
% Create figure of sample histograms of SAR land/water superpixels
% SENTINEL version
%
% March 2020
% O. Pappas
%%%%%%%%%%%%%%%%%%


% CLEAR
clear all;
close all;

load('sentinel_crops.mat');
img = img(:,:,1) + 1;
figure, imshow(img,[]);
title('Original SAR Image');
[h, l] = size(img);

% MISP PARAMETERS
% RegionSize is the starting size of the superpixels.
RegionSize = 20;
% MOD MISP GGD SUPERPIXEL SEGMENTATION
% Default concentration parameter value
maxiter = 25; % CRASH ON 14th ITER, NEEDS FIXING
alfa = 10e4;
% Generate raw MISP superpixel
sMap = mod_misp_GGD(img,RegionSize,alfa,maxiter);
% Cleanup small regions
areaThresh = (RegionSize^2)/20;
connectivity = 8;
[supMap, Am] = cleanupregions(sMap, areaThresh, connectivity);
% VIEW SEGMENTATION MAP
% Find superpixel boundaries
boundMap = drawregionboundaries(supMap);
figure
imshow(imoverlay(img/255,boundMap,'r'));
title('MISP Generalised Gamma Superpixel Map');


% COMPILE SUPERPIXELS IN CELL ARRAY
spixel_total = max(unique(supMap));
spixels = cell(spixel_total,1);
for ii = 1:h
    for jj = 1:l
        curr_sp_label = supMap(ii,jj);
%         spixels{curr_sp_label} = [spixels{curr_sp_label} img(ii,jj)];
        spixels{curr_sp_label} = [spixels{curr_sp_label} (img(ii,jj)+1)]; % ADD 1 VERS, AVOID 0 NAKAGAMI
    end
end

% For this example: 
binnum = 25;
% dim = [0.7, 0.5, 0.35, 0.35];
dim = [0.619642857142857 0.647619047619048 0.273214285714286 0.266666666666669];

land_spixel = supMap(106,53);
figure, histogram(spixels{land_spixel},binnum);
med = median(spixels{land_spixel});
dev = std(spixels{land_spixel});
[~, ~, ggdS] = mod_gGd_param_est(spixels{land_spixel});
entro = inf_entropy(spixels{land_spixel});
% ANNOTATION
str = {'median = 101', 'st.dev = 39.4', 'GGD \sigma = 109.1', 'entropy = 6'};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',14);
ylabel('Pixel Count','FontSize',14);
xlabel('Pixel Intensities','FontSize',14);


land_spixel2 = supMap(111,82);
figure, histogram(spixels{land_spixel2},binnum);
med = median(spixels{land_spixel2});
dev = std(spixels{land_spixel2});
[~, ~, ggdS] = mod_gGd_param_est(spixels{land_spixel2});
entro = inf_entropy(spixels{land_spixel2});
% ANNOTATION
str = {'median = 101', 'st.dev = 56.7', 'GGD \sigma = 116.7', 'entropy = 6.35'};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',14);
ylabel('Pixel Count','FontSize',14);
xlabel('Pixel Intensities','FontSize',14);

water_spixel = supMap(108,69);
figure, histogram(spixels{water_spixel},binnum);
med = median(spixels{water_spixel});
dev = std(spixels{water_spixel});
[~, ~, ggdS] = mod_gGd_param_est(spixels{water_spixel});
entro = inf_entropy(spixels{water_spixel});
% ANNOTATION
str = {'median = 2', 'st.dev = 4.5', 'GGD \sigma = 1.7', 'entropy = 1.25'};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',14);
ylabel('Pixel Count','FontSize',14);
xlabel('Pixel Intensities','FontSize',14);

