% Calculate Gaussian probability density function
% x: Data 
% a: Mean vector of Gaussian
% B: Covariance matrix of Gaussian
% d: Dimension of Gaussian

% y: Gaussian probability density function

function y = GaussNDPdf(x,a,B,d)

N = length(x(:,1));
dx = zeros(N,d);
for l=1:d
    dx(:,l) = (x(:,l) - a(l));
end
dxS = dx*inv(B);
dxSdx = zeros(N,1);
for n = 1:N
    dxSdx(n) = dxS(n,:)*dx(n,:)';
    if dxSdx(n)<0
        dxSdx(n);
    end
end
logy =  - 0.5*dxSdx;
y = exp(logy);
