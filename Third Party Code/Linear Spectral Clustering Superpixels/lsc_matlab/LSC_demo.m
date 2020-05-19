% You are free to use, change or redistribute this code for any
% non-commrecial purposes.If you use this software,please cite the
% following in any resulting publication and email us:
% [1] Zhengqin Li, Jiansheng Chen, Superpixel Segmentation using Linear 
%     Spectral Clustering, IEEE Conference on Computer Vision and Pattern 
%     Recognition (CVPR), Jun. 2015 
% (C) Zhengqin Li, Jiansheng Chen, 2014
% li-zq12@mails.tsinghua.edu.cn
% jschenthu@mail.tsinghua.edu.cn
% Tsinghua University

clear all;clc;close all;

name='02';
img=imread([name,'.jpg']);
gaus=fspecial('gaussian',3);
I=imfilter(img,gaus);

superpixelNum=200;
ratio=0.075;

label=LSC_mex(I,superpixelNum,ratio);

DisplaySuperpixel(label,img,name);

DisplayLabel(label,name);





