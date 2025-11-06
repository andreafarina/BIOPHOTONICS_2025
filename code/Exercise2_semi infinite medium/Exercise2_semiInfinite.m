%% Time-resolved fluence in a semi-infinite medium
% Exercise 2
% Objective: 
% Implement, plot ans study the function TDInfinite.m  for the time-domain 
% solution of the Diffusion Equation in an infinite diffusive medium.
% 1. fix SD distance, musprime, change mua and plot.
% 2. fix SD distance, mua, change musprime and plot
% 3. fix mua and musprime, change SD distance, compare with MC simulations and plot
% 4. plot the fluence map in 3D as a function of time (slice in a xz plane)

% Author: Andrea Farina - CNR, POLIMI                       October 2025

clearvars;
close all;
%% define parameters
n = 1.4;    % refractive index of the medium
dt = 5;     % time step
N = 2000;   % number of time points
mua = 0.1;  % [cm-1] absorption coefficient
musp = 10;  % [cm-1] reduced scattering coefficient
t = (0:N-1) * dt + dt/2;  % time vector
SourcePos = [0, 0, 0];
DetPos = [2, 0, 0];

y = TDSemiInfinite_EBC(SourcePos,DetPos,n,mua,musp,t);

figure(1),semilogy(t,y),
ylim([1e-10 1e-6]);

%% Exercise 2.1: fix detector position, change mua and plot
muavector = 0:0.01:0.2;
figure(2),
for imua = muavector
    y = TDSemiInfinite_EBC(SourcePos,DetPos,n,imua,musp,t);
    semilogy(t,y),hold on;
end
ylim([1e-8 1e-3]),
xlabel('time (ps)'),
ylabel('fluence [cm-2 * ps-1]'),grid,
title('change mua')


%% Exercise 2.2: fix detector position, change musprime and plot
muspvector = 5:20;
figure(3),
for imusp = muspvector
    y = TDSemiInfinite_EBC(SourcePos,DetPos,n,mua,imusp,t);
    semilogy(t,y),hold on;
end
ylim([1e-8 1e-3]),
xlabel('time (ps)'),
ylabel('fluence [cm-2 * ps-1]'),grid,
title('change musprime')


%% Exercise 2.3: fix mua and musprime, change detector position and plot and compare
%% with MC simulations
detvector = 1:1:4;
load Homo_MC.mat;% Load MC simulations in a 2000x4 matrix with SD = 1,2,3,4 cm
figure(4),
for idet = detvector
    y = TDSemiInfinite_EBC(SourcePos,[idet,0,0],n,mua,musp,t);
    semilogy(t,y),hold on;
end
semilogy(t,yMC)
ylim([1e-12 1e-4]),
xlabel('time (ps)'),
ylabel('fluence [cm-2 * ps-1]'),grid,
title('change SD distance')

%% Exercise 2.4: plot the fluence map in 3D as a function of time
% define a volume
X = -10:0.1:10;
Y = -10:0.1:10;
Z = -10:0.1:20;
[XX,YY,ZZ] = meshgrid(X,Y,Z);
Pos = [XX(:),YY(:),ZZ(:)];
figure(5),
clim = [-50,-3];
ysec = 100;
for it = 1:100
    Fluence = TDSemiInfinite_EBC(SourcePos,Pos,n,mua,musp,t(it));
    Fluence3D = reshape(Fluence,size(XX));
    figure(5),imagesc(X,Z,squeeze(log(Fluence3D(:,ysec,:)))',clim),colorbar, axis image,
    xlabel('x [cm]'), ylabel('z [cm]')
    drawnow,pause(0.1);
end
