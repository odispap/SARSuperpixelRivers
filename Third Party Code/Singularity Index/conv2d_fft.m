function output = conv2d_fft(image,h)

% This function uses the FFT-convolution theorem to produce an output that is identical to:
% imfilter(image,h,'symmetric','same','conv'), i.e. the function first pads
% the image by mirroring the borders and then performs FFT-based
% convolution. This ameliorates boundary effects. The size of the output is
% the same as the size of the image input to the function.

% size of the filter and the input image
size_h = size(h);
size_image = size(image);

% First pad image to mirror the borders, assume filter size to be always odd 
padsize = (size_h-1)/2;
img = padarray(image,padsize,'symmetric');

% now perform convolution via MATLAB's FFT by using img as the input image. 
% img will now be zero padded by MATLAB's FFT routine.

size_img = size(img);

output = ifft2(fft2(img,(size_img(1)+size_h(1)-1), (size_img(2)+size_h(2)-1))...
    .* fft2(h,(size_img(1)+size_h(1)-1), (size_img(2)+size_h(2)-1))...
    );

% Now extract the central part of the convolution of img and h
output = output(1+floor(size_h(1)/2):(size_img(1)+size_h(1)-1)-floor(size_h(1)/2),...
    1+floor(size_h(2)/2):(size_img(2)+size_h(2)-1)-floor(size_h(2)/2));

% Now again extract the central part of the convolution of the original
% image and h
output = output(1+floor(size_h(1)/2):(size_image(1)+size_h(1)-1)-floor(size_h(1)/2),...
    1+floor(size_h(2)/2):(size_image(2)+size_h(2)-1)-floor(size_h(2)/2));

output = real(output);