function [v,kapa, sigma] = gGd_param_est(data)
%GGD_PARAM_EST 
% Estimators for the parameters of the Generalised Gamma Distribution
% From Heng-Chao Li et al. 2011
% "On the Empirical-Statistical Modeling of SAR Images With Generalized
%  Gamma Distribution"

% Lets do some calcs

N = length(data);

% log-moments and log-cumulants
m1 = (1/N)*sum(log(data));
k1 = m1;

m2 = (1/N)*sum((log(data)).^2);
k2 = m2 - m1^2;
k2b = (1/N)*sum((log(data) - m1).^2);

m3 = (1/N)*sum((log(data)).^3);
k3 = m3 - 3*m1*m2 + 2*m1^3;

% Terms
a0 = 8*k3^2;
a1 = 4*(3*k3^2 - 2*k2^3);
a2 = 2*(3*k3^2 - 8*k2^3);
a3 = k3^2 - 8*k2^3;

p = (3*a0*a2 - a1^2)/(3*a0^2);
q = (2*a1^3 - 9*a0*a1*a2 + 27*(a0^2)*a3)/(27*a0^3);

% Parameters
kapa = -a1/(3*a0) + nthroot((-q/2)+sqrt((q/2)^2 + (p/3)^3), 3) + nthroot((-q/2)-sqrt((q/2)^2 + (p/3)^3), 3);
v = sign(-k3) * sqrt((1/k2)*psi(1,kapa));
sigma = exp(k1 - ((psi(0,kapa)-log(kapa))/v));

end

