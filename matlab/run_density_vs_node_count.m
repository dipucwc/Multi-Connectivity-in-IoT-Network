%%
%% Node Density versus Coverage Count:
%%
%{
Sweeps the deployed node count (seeded per sweep point), computes the density lambda = n / (L W), and
evaluates the number of nodes inside a fixed 100 m radius. The count grows linearly with lambda; the
closed-form expectation lambda pi R^2 is overlaid.

Auxiliary functions:

    default_parameters, verify_model, generate_node_positions, calculate_distances,
    count_nodes_within_radius, save_project_figure

Output:

    plots/02_density_vs_node_count.png
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

%% Density sweep:
%%

R = 100;
lambda = cfg.nodeCountVector / (cfg.areaLength_m * cfg.areaWidth_m);
countInRadius = zeros(size(cfg.nodeCountVector));
for k = 1:numel(cfg.nodeCountVector)
    pos = generate_node_positions(cfg.nodeCountVector(k), cfg.areaLength_m, cfg.areaWidth_m);
    countInRadius(k) = count_nodes_within_radius(calculate_distances(pos, cfg.centerPosition_m), R);
end

figureHandle = figure('Name', 'Density versus Node Count', 'NumberTitle', 'off');
plot(lambda, countInRadius, '-o', 'LineWidth', 1.2); hold on;
plot(lambda, lambda*pi*R^2, 'k--');                  % closed-form expectation lambda*pi*R^2
grid on; xlabel('Node density \lambda (nodes/m^2)'); ylabel(sprintf('Nodes within R = %d m', R));
title('Coverage count versus node density');
legend('Seeded deployment', 'Expectation \lambda\piR^2', 'Location', 'northwest');
if cfg.savePlots
    save_project_figure(figureHandle, cfg.plotDirectory, '02_density_vs_node_count.png');
end
