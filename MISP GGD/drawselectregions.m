% DRAWREGIONBOUNDARIES Draw boundaries of labeled regions in an image
%
% Usage: maskim = drawregionboundaries(l, im, col, winners, col2)
%
% Arguments:
%            l - Labeled image of regions.
%           im - Optional image to overlay the region boundaries on.
%          col - Optional colour specification. Defaults to black.  Note that
%                the colour components are specified as values 0-255.
%                For example red is [255 0 0] and white is [255 255 255].
%
% Returns: 
%       maskim - If no image has been supplied maskim is a binary mask
%                image indicating where the region boundaries are.
%                If an image has been supplied maskim is the image with the
%                region boundaries overlaid 
%
% See also: MASKIMAGE

function maskim = drawselectregions(l, im, col, winners, col2)
    
    % Form the mask by applying a sobel edge detector to the labeled image,
    % thresholding and then thinning the result.
%    h = [1  0 -1
%         2  0 -2
%         1  0 -1];
    h = [-1 1];  % A simple small filter is better in this application.
                 % Small regions 1 pixel wide get missed using a Sobel
                 % operator 
    gx = filter2(h ,l);
    gy = filter2(h',l);
     maskim = (gx.^2 + gy.^2) > 0;
     maskim = bwmorph(maskim, 'thin', Inf);
    
    % Zero out any mask values that may have been set around the edge of the
    % image.
     maskim(1,:) = 0; maskim(end,:) = 0;
     maskim(:,1) = 0; maskim(:,end) = 0;
    
    % If an image has been supplied apply the mask to the image and return it 
    if exist('im', 'var') 
       if ~exist('col', 'var'), col = 0; end
         maskim = maskimage(im, maskim, col);
   end
    
        
     num_of_labels = max(max(l));
     [ii jj] = size(l);
     l2 = l;
     for i=1:ii
         for j=1:jj
             flag = ismember(l(i,j),winners);
             if flag == 0
                 l2(i,j) = 1;
             end;
         end;
     end;
    
    gx2 = filter2(h ,l2);
    gy2 = filter2(h',l2);
    maskim2 = (gx2.^2 + gy2.^2) > 0;
    maskim2 = bwmorph(maskim2, 'thin', Inf);
    maskim2(1,:) = 0; maskim2(end,:) = 0;
    maskim2(:,1) = 0; maskim2(:,end) = 0;
    
    maskim = maskimage(maskim, maskim2, col2);
     
     kek = 88;
%     for i=1:num_of_labels
%         flag = ismember(i,winners);
%         if flag == 0
%             maskim = maskimage(im, maskim, col);
%         end;
%     end;