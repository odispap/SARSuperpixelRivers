%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demo script. 
%
% Iteratively read in number of crops from SENTINEL image stack and for each
% - Perform MISP-GGD
% - Extract features
% - Perform Agglomerative Clustering of Superpixels
% - Visualise Results 
%
%
% O. Pappas
% July 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all; 

load('sentinel_crops.mat');
[h, l, layers] = size(img);

for scene = 1:layers
    
    im = img(:,:,scene) + 1;
    figure, imshow(im,[]);
    title(['SAR Image ',num2str(scene)]);
    
    % Singularity Index
    [psi,~,~,~] = MODSingularityIndex2D(im, 10, 0, 6);
    
    % MISP PARAMETERS
    RegionSize = 20; %25 Default
    alfa = 1000000;

    % MISP SUPERPIXEL SEGMENTATION
%     sMap = misp(im,RegionSize,alfa);
%             % OR MISP-CR
%             maxiter = 40;
%             sMap = mod_misp_CR(im,RegionSize,alfa,maxiter);
            % OR MISP-GGD
            maxiter = 20;
            sMap = mod_misp_GGD2(im,RegionSize,alfa,maxiter);
    areaThresh = (RegionSize^2)/20;
    connectivity = 8;
    [supMap, Am] = cleanupregions(sMap, areaThresh, connectivity);
    

    % VIEW SEGMENTATION MAP
    boundMap = drawregionboundaries(supMap);
    figure
    imshow(imoverlay(im/255,boundMap,'r'));
    title(['MISP Superpixel Map ', num2str(scene)]);
    
    % COMPILE SUPERPIXELS IN CELL ARRAY
    spixel_total = max(unique(supMap));
    spixels = cell(spixel_total,1);
    SIspixels = cell(spixel_total,1);
    for ii = 1:h
        for jj = 1:l
            curr_sp = supMap(ii,jj);
            spixels{curr_sp} = [spixels{curr_sp} im(ii,jj)];
            SIspixels{curr_sp} = [SIspixels{curr_sp} psi(ii,jj)]; %Save the SI values per spixel
        end
    end
    
    % FEATURES
    % Do these need to be normalised? Yes
    feat_count = 4;
    FEATURES = zeros(spixel_total,feat_count);
    for ii = 1:spixel_total
        data = spixels{ii};
        % ENTROPY
        FEATURES(ii,1) = inf_entropy(data);
        % MEDIAN 
        FEATURES(ii,2) = median(data);
        % MEAN SI 
        FEATURES(ii,3) = mean(SIspixels{ii});
        % GGD_S
        [~, ~, ggdS] = mod_gGd_param_est(data);
        FEATURES(ii,4) = ggdS;
    end
    % Normalise Features in 0 to 1 range
    FEATURES = normalize(FEATURES,1,'range');
%     FEATURES = normalize(FEATURES,1);
    
    % ADD OPTIONAL PCA HERE
    
    % USE AGGLOMERATIVE/HIERARCHICAL CLUSTERING
    cutoff = 2;
    Y = pdist(FEATURES,'euclidean');
    dendro = linkage(Y,'ward');
    Z = cluster(dendro, 'maxclust', cutoff);
    
    % DRAW MASK
    winners = find(Z == 1); % Decide to draw first cluster
    mask = zeros(h,l);
    for ii = 1:h
        for jj = 1:l
            curr_sp = supMap(ii,jj);
            if find(winners == curr_sp)
                mask(ii,jj) = 1;
            end
        end
    end
    figure, imshow(mask,[]);
    title(['River Mask ', num2str(scene)]);
end
