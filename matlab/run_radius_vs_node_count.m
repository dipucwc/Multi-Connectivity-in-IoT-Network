%%
%% Radius versus Node Count:
%%
%{
Deploys the candidate nodes over the service area (seeded), calculates their distances from the
reference location, and evaluates the number of available nodes over the coverage-radius sweep. The
regression checks run first and the script stops if any check fails.

Auxiliary functions:

    default_parameters, verify_model, generate_node_positions, calculate_distances,
    count_nodes_within_radius, save_project_figure

Output:

    Command Window            Node counts at selected radii.
    plots/01_radius_vs_node_count.png
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

%% Deployment and counting:
%%

positions_m = generate_node_positions(cfg.numberOfCandidateNodes, cfg.areaLength_m, cfg.areaWidth_m);
distances_m = calculate_distances(positions_m, cfg.centerPosition_m);
nodeCount   = count_nodes_within_radius(distances_m, cfg.radiusVector_m);

figureHandle = figure('Name', 'Radius versus Node Count', 'NumberTitle', 'off');
plot(cfg.radiusVector_m, nodeCount, '-o', 'LineWidth', 1.2, 'MarkerSize', 5);
grid on; xlabel('Coverage radius (m)'); ylabel('Number of available nodes');
title('Available nodes versus coverage radius');
if cfg.savePlots
    save_project_figure(figureHandle, cfg.plotDirectory, '01_radius_vs_node_count.png');
end

for R = [50 100 200]
    fprintf('  R = %3d m: %d nodes (expected %.1f)\n', R, ...
        nodeCount(cfg.radiusVector_m == R), ...
        cfg.numberOfCandidateNodes*pi*R^2/(cfg.areaLength_m*cfg.areaWidth_m));
end
