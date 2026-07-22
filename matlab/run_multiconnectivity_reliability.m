%%
%% Multi-Connectivity Reliability:
%%
%{
Compares the analytical availability 1 - (1 - p)^K for single, dual, and triple connectivity over the
link-availability sweep, with seeded Monte Carlo trials as a numerical cross-check at selected values.
The Monte Carlo markers must lie on the analytical curves; at p = 0.9 the closed-form values are
0.9, 0.99, and 0.999. With 200000 trials the estimator resolves outage down to about 1e-5; points with
analytical outage below that (K = 3 at p = 0.99, outage 1e-6) are shown as gaps rather than
quantization artifacts.

Auxiliary functions:

    default_parameters, verify_model, calculate_multiconnectivity_availability, save_project_figure

Output:

    Command Window            Analytical and Monte Carlo availability at p = 0.9.
    plots/05_multiconnectivity_reliability.png
%}


%% Initialization:
%%

clc; close all;
here = fileparts(mfilename('fullpath'));
addpath(here);

cfg = default_parameters();
if ~verify_model()
    error('Regression checks failed.');
end
rng(cfg.randomSeed, 'twister');

%% Analytical curves and Monte Carlo cross-check:
%%

p = cfg.linkAvailabilityVector;
K = cfg.connectivityOrderVector;
A = zeros(numel(K), numel(p));
for k = 1:numel(K)
    A(k, :) = calculate_multiconnectivity_availability(p, K(k));
end

pSel = [0.85, 0.90, 0.95, 0.99];
Amc = zeros(numel(K), numel(pSel));
for k = 1:numel(K)
    for j = 1:numel(pSel)
        trials = rand(cfg.monteCarloRuns, K(k)) < pSel(j);   % one row per trial, one column per link
        Amc(k, j) = mean(any(trials, 2));
        if (1 - Amc(k, j)) < 2/cfg.monteCarloRuns    % below estimator resolution: show a gap
            Amc(k, j) = NaN;
        end
    end
end

figureHandle = figure('Name', 'Multi-Connectivity Reliability', 'NumberTitle', 'off');
semilogy(p, 1 - A(1, :), '-', p, 1 - A(2, :), '-', p, 1 - A(3, :), '-', 'LineWidth', 1.2); hold on;
for k = 1:numel(K)
    semilogy(pSel, 1 - Amc(k, :), 'k^', 'MarkerSize', 6);
end
grid on; xlabel('Individual-link availability p'); ylabel('Outage probability 1 - A');
title('Outage versus link availability for K = 1, 2, 3');
legend('K = 1', 'K = 2', 'K = 3', 'Monte Carlo', 'Location', 'southwest');
if cfg.savePlots
    save_project_figure(figureHandle, cfg.plotDirectory, '05_multiconnectivity_reliability.png');
end

for k = 1:numel(K)
    fprintf('  K = %d @ p = 0.90: analytical %.4f, Monte Carlo %.4f\n', ...
        K(k), calculate_multiconnectivity_availability(0.9, K(k)), Amc(k, 2));
end
