%% Inverse problem: retrieve optical properties
% Exercise 3
% Objective: 
% Load simulated-experimental curves and find the optical properties mua and musprime
% that best fit the data.
% 1. load Homo_MC.mat.
% 2. implement a simple fit using the command lsqcurvefit.
% 3. try to fit the 4 curves at different Source-Detector distance. What do
%    you observe?
% 4. try different set of initial parameters and fit. What do you observe?
%    Is the result changing with the initial guess?
% 5. Start with initial guess the exact parameters of MC simulations:
%    mua = 0.1cm-1 and musp = 10cm-1. 
%    - Calculate the ChiSquare.
%    - Run the fit and calculate the ChiSquare using the fitted mua and
%    musp. 
%    - compare it to the one calcualated above. What do you observe?

% Author: Andrea Farina - CNR, POLIMI                       November 2025

clearvars;
close all;

%% define parameters
n = 1.4;    % refractive index of the medium
dt = 5;     % time step [ps]
N = 2000;   % number of time points
t = (0:N-1) * dt + dt/2;  % time vector [ps]
t = t';

%% load simulated data
load Homo_MC.mat
iMC = 4; % select one           
%   iMC = 1 --> SD distance of 1cm;
%   iMC = 2 --> SD distance of 2cm;
%   iMC = 3 --> SD distance of 3cm;
%   iMC = 4 --> SD distance of 4cm;

ydata = yMC(:,iMC);

%% set Source-Detector distance accordingly to the choice above
SourcePos = [0, 0, 0];
DetPos = [4, 0, 0]; % [cm]

%% Normalize data to the area
ydata = ydata./sum(ydata);  

%% ================== START INVERSE PROBLEM ==============================
%% Set initial guess of mua/musp
mua0 = 0.15;    % [cm-1] absorption coefficient
musp0 = 11;     % [cm-1] reduced scattering coefficient

%% plot data vs initial guess
ymodel = TDSemiInfinite_EBC_normalized(SourcePos,DetPos,n,mua0,musp0,t);
figure(1),subplot(1,2,1),semilogy(t,ydata,t,ymodel),
ylim([1e-4 1e-1]),xlabel('time (ps)'),
ylabel('[arb. units]'),grid,title('Initial guess')

%% Implement here the fit using lsqcurvefit. Please read the help/documentation
%% of this function

%% diplay fitted parameters results

%% plot data vs final model 
figure(1), subplot(1,2,2),semilogy(t, ydata,t, ymodel_fit),grid
ylim([1/N 1e-1]), xlabel('time (ps)'),
ylabel('[arb. units]'),
legend('Data', 'Fitted Model'),title('Fitted model')
