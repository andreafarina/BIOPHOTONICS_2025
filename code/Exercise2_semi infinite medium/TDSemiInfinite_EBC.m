function y = TDSemiInfinite_EBC(SourcePos,DetPos, n, mua, musp, time)
%% Green function for the time-domain solution under the Diffusion Equation
%  SourcePos:   [xs,ys,zs] vector of the source position
%  DetPos:      [xd,ys,zd] vector of the detector position
%  n:           reftactive index
%  mua:         absorption coefficient
%  musp:        reduced scattering coefficient
%  time:        time
% % Author: Andrea Farina - CNR, POLIMI                       October 2025

c0 = 0.03;  % [cm/ps] speed of light in vacuum
D = 1/(3*musp);
v = c0/n;

%% EBC
A = Afactor(1,n);
D = 1/(3*musp);
ze = 2 * A * D;
zs = 1/musp;
zm = -zs - 2*ze;

%% shift source vector
Splus = SourcePos + [0, 0, zs];
Sminus = SourcePos + [0, 0, zm];

rplus = sqrt(sum((Splus - DetPos).*(Splus - DetPos),2));
yplus = v.*(4*pi*D*v*time).^(-3/2) .* exp(-rplus.^2./(4*D*v*time)) .* exp(-mua * v * time);

rneg = sqrt(sum((Sminus - DetPos).*(Sminus - DetPos),2));
yneg = v.*(4*pi*D*v*time).^(-3/2) .* exp(-rneg.^2./(4*D*v*time)) .* exp(-mua * v * time);

y = yplus - yneg;
y = y./(2*A);

y(y<0) = 0;

return;
