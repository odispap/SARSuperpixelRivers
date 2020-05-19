% Function to calculate Generalised Gamma Distribution pdf for given input
% data and parameter space [v,k,s]
%
% Odysseas Pappas
% June 2019


function px = gGd_pdf(data, vgdd ,kgdd ,sgdd)

if nargin < 4
    error('Requires data input + [v,k,s] parameter space as input arguments.');
end

for k=1:length(data)
    currx = data(k);
    T1 = (abs(vgdd) * kgdd^kgdd) / (sgdd*gamma(kgdd));
    T2 = (currx/sgdd)^(kgdd*vgdd-1);
    T3 = exp(-kgdd*(currx/sgdd)^vgdd);
    px(k) = T1 * T2 *T3;
end

px = px';
end