%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for plotting GGD pdf for various parameter combinations, to
% illustrate the descriptive ability of the distribution.
%
% O. Pappas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all 
close all 


% Test case
global sggd
global vggd
global kggd

% FIG 1
figure
hold on;
xlabel('x');
ylabel('p(x)');

sggd = 2;
vggdarr = [ -1.0, 1.0, 1.5, 2.0, 2.5];
kggd = 1.2;

for i = 1:5
    vggd = vggdarr(i);
    pdf = @(x) (abs(vggd) * kggd^kggd) / (sggd*gamma(kggd))*((x/sggd)^(kggd*vggd-1))*(exp(-kggd*(x/sggd)^vggd));
    fplot(pdf,[0,10]);
end
% LEGEND
legend(['\nu = -1.0'],['\nu = 1.0'],['\nu = 1.5'],['\nu = 2.0'],['\nu = 2.5']);
% VARIABLE ANNOTATION
dim = [0.725, 0.4, 0.1, 0.1];
str = {'\sigma = 2', '\kappa = 1.2'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');



% FIG 2
figure
hold on;
xlabel('x');
ylabel('p(x)');

sggd = 2;
vggd = 1.5;
kggdarr = [ 1.0, 2.0, 3.0, 5.0]; %5.0 last

for i = 1:4
    kggd = kggdarr(i);
    pdf = @(x) (abs(vggd) * kggd^kggd) / (sggd*gamma(kggd))*((x/sggd)^(kggd*vggd-1))*(exp(-kggd*(x/sggd)^vggd));
    fplot(pdf,[0,10]);
%     area_under_pdf = integral(pdf, 0, 10)
end
% LEGEND
legend(['\kappa = 1.0'],['\kappa = 2.0'],['\kappa = 3.0'],['\kappa = 5.0']);
% VARIABLE ANNOTATION
dim = [0.725, 0.4, 0.1, 0.1];
str = {'\sigma = 2', '\nu = 1.5'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

% FIG 3
figure
hold on;
xlabel('x');
ylabel('p(x)');

vggd = 1.5;
kggd = 1.5;
sggdarr = [ 1.0, 2.0, 3.0, 5.0]; %5.0 last

for i = 1:4
    sggd = sggdarr(i);
    pdf = @(x) (abs(vggd) * kggd^kggd) / (sggd*gamma(kggd))*((x/sggd)^(kggd*vggd-1))*(exp(-kggd*(x/sggd)^vggd));
    fplot(pdf,[0,10]);
%     area_under_pdf = integral(pdf, 0, 10)
end
% LEGEND
legend(['\sigma = 1.0'],['\sigma = 2.0'],['\sigma = 3.0'],['\sigma = 5.0']);
% VARIABLE ANNOTATION
dim = [0.725, 0.4, 0.1, 0.1];
str = {'\kappa = 1.5', '\nu = 1.5'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');





