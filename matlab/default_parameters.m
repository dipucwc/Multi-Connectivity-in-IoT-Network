function cfg = default_parameters()
%%
%% Default Simulation Parameters:
%%
%{
Central configuration of the multi-connectivity IoT study. The values use normalized model units carried
over from the original scripts: transmit powers and the noise power are dimensionless (N0 = 1), the
bandwidth constant W = 100 scales the Shannon capacity, and distances are in metres over a 1000 x 1000 m
service area. Every analysis and the regression checks read this one structure, and the seed makes every
random deployment and Monte Carlo run reproducible.

Output:

    cfg          Structure with reproducibility, geometry, sweep, capacity-model, reliability,
                 Monte Carlo, numerical-protection, and plot-output settings.
%}

%% Reproducibility:
%%

cfg.randomSeed = 7;

%% Network geometry:
%%

cfg.areaLength_m            = 1000;
cfg.areaWidth_m             = 1000;
cfg.centerPosition_m        = [500, 500];
cfg.numberOfCandidateNodes  = 1000;
cfg.radiusVector_m          = 10:10:250;

%% Node-density sweep:
%%

cfg.nodeCountVector = 100:100:1000;

%% Capacity-model parameters (normalized units):
%%

cfg.bandwidth_Hz               = 100;
cfg.noisePower                 = 1;
cfg.pathLossExponentVector     = [2, 4];
cfg.referenceTransmitPower     = 5;
cfg.remoteTransmitPowerVector  = 1:10;
cfg.capacityThresholdVector    = [0.05, 0.10, 0.20];  % matched to the capacity scale of the
                                                      % geometry: C ~ 721/d^2, about 0.07 at 100 m

%% Reliability-analysis parameters:
%%

cfg.linkAvailabilityVector  = 0.80:0.01:0.999;
cfg.connectivityOrderVector = 1:3;

%% Monte Carlo and numerical protection:
%%

cfg.monteCarloRuns    = 200000;   % resolves outage down to ~1e-5; smaller outages appear as gaps
cfg.minimumDistance_m = 1e-3;

%% Plot output:
%%

cfg.savePlots     = true;
cfg.plotDirectory = fullfile(fileparts(mfilename('fullpath')), '..', 'plots');
end
