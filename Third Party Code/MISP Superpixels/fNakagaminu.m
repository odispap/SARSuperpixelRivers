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

% Estimating the shape parameter nu of Nakagami 
% distribution.
% s         : Intensities of the class members
% mu        : Mean of the Nakagami
% Nc        : Number of pixels in the class
% numax     : maximum value of nu
% nuold     : current value of nu

% nu        : estimated value of nu

function [nu]=fNakagaminu(s,mu,Nc,numax)


avlogs=2*sum(log(s))/Nc;
f = @(x)(-psi(0,x)+log(x/mu)+avlogs);

if f(numax)>=0
    z = numax;
else
    z = fzero(f,[1e-5 numax]);
end
z(z<=0)=1e-5;

nu=z;