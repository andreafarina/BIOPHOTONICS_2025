function y = TDSemiInfinite_EBC(SourcePos,DetPos, n, mua, musp, time)
%% Green function for the time-domain solution under the Diffusion Equation
%  SourcePos:   [xs,ys,zs] vector of the source position
%  DetPos:      [xd,ys,zd] vector of the detector position
%  n:           reftactive index
%  mua:         absorption coefficient
%  musp:        reduced scattering coefficient
%  time:        time
% % Author: Andrea Farina - CNR, POLIMI                       October 2025


%% fill here the function

y(y<0) = 0; % to filter values < 0.

return;
