% CIRCULARSTRUCT
%
% Function to construct a circular structuring element
% for morphological operations.
%
% function strel = circularstruct(radius)
%
% Note radius can be a floating point value though the resulting
% circle will be a discrete approximation
%
% Peter Kovesi   March 2000

function strel = circularstruct(radius)

if radius < 1
  error('radius must be >= 1');
end

dia = ceil(2*radius);  % Diameter of structuring element

if mod(dia,2) == 0     % If diameter is a odd value
 dia = dia + 1;        % add 1 to generate a `centre pixel'
end

r = fix(dia/2);
x = ones(dia,1)*[-r:r];    % Matrix with each pixel set to its x coordinate relative to the centre
y = [-r:r]'*ones(1,dia);   %   "     "     "    "    "  "   "  y    "         "       "   "   "
rad = sqrt(x.^2 + y.^2);   %   "     "     "    "    "  "   "  radius from the middle
strel = rad<=radius;