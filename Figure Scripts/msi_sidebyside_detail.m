%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Side by side detail of SAR img & MSI output for figure
% 
% Oct 2019
% O. Pappas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all 
clear all 


im1 = imread('ICEYE_5_ORIG.png');
im2 = imread('ICEYE_5_MSI.png');

figure, imshow(im1,[]);
figure, imshow(im2,[]);

im1det = im1(60:209,130:204);
figure, imshow(im1det,[]);
im2det = im2(60:209,130:204);
figure, imshow(im2det,[]);

im1 = imread('ICEYE_9_ORIG.png');
im2 = imread('ICEYE_9_MSI.png');

figure, imshow(im1,[]);
figure, imshow(im2,[]);

im1det = im1(110:259,90:164);
figure, imshow(im1det,[]);
im2det = im2(110:259,90:164);
figure, imshow(im2det,[]);