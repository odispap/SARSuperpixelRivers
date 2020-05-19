%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2013, Koray Kayabol, Josiane Zerubia% 
% <koray.kayabol@gtu.edu.tr>,                       %
% <josiane.zerubia@inria.fr>                        %             
% All rights reserved               			    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K. Kayabol and J. Zerubia, “Unsupervised amplitude 
% and texture classification of SAR images with 
% multinomial latent model,” IEEE Trans. Image 
% Process., vol. 22, no. 2, pp. 561-572, Feb., 2013.

% Calculate Nakagami probability density function
% x: Data 
% a: shape parameter nu 
% b: shape parameter nu /scale parameter mu 

% y: Nakagami probability density function

function y = NakagamiPdf(x,a,b)

logy = log(2) + a*log(b) + (2*a-1)*log(x) - b*x.^2 - gammaln(a);
y = exp(logy);