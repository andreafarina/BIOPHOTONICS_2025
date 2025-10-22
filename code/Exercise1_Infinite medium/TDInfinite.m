function y = TDInfinite(SourcePos,DetPos, n, mua, musp, time)
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
r = sqrt(sum((SourcePos - DetPos).*(SourcePos - DetPos),2));

y = v.*(4*pi*D*v*time).^(-3/2) .* exp(-r.^2./(4*D*v*time)) .* exp(-mua * v * time);

return;

