%%
%% Coverage under Joint Radius and Capacity Constraints:
%%
%{
Deploys the candidate nodes (seeded), assigns every node the interference-limited capacity of its link to
the reference point (one common interferer geometry), and evaluates how many nodes satisfy the coverage
radius and a minimum-capacity threshold simultaneously, for each threshold of the configuration. The
thresholds are matched to the capacity scale of the geometry (C ~ 721/d^2 normalized, about 0.07 at
100 m), so the curves separate and saturate near the threshold-limited distances of roughly 120, 85,
and 60 m; thresholds of order 1 would select only nodes within ~25 m and give a degenerate
single-node result.

Auxiliary functions:

    default_parameters, verify_model, generate_node_positions, calculate_distances,
    calculate_link_capacity, count_qualified_nodes, save_project_figure

Output:

    plots/03_capacity_threshold_analysis.png
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

%% Deployment, per-node capacity, and qualified counting:
%%

positions_m = generate_node_positions(cfg.numberOfCandidateNodes, cfg.areaLength_m, cfg.areaWidth_m);
distances_m = calculate_distances(positions_m, cfg.centerPosition_m);

interfererDistance_m = 200;                          % one fixed interferer geometry for the whole sweep
nodeCapacity = zeros(size(distances_m));
for k = 1:numel(distances_m)
    nodeCapacity(k) = calculate_link_capacity( ...
        cfg.referenceTransmitPower, distances_m(k), 1, interfererDistance_m, ...
        cfg.bandwidth_Hz, cfg.noisePower, 2, cfg.minimumDistance_m);
end

figureHandle = figure('Name', 'Capacity Threshold Analysis', 'NumberTitle', 'off');
hold on; grid on;
markers = {'-o', '-s', '-^'};
for t = 1:numel(cfg.capacityThresholdVector)
    q = count_qualified_nodes(distances_m, nodeCapacity, ...
        cfg.radiusVector_m, cfg.capacityThresholdVector(t));
    plot(cfg.radiusVector_m, q, markers{t}, 'LineWidth', 1.1, 'MarkerSize', 4);
end
xlabel('Coverage radius (m)'); ylabel('Qualified nodes');
title('Nodes meeting radius and capacity conditions');
legend(arrayfun(@(c) sprintf('C_{th} = %.2f', c), cfg.capacityThresholdVector, ...
       'UniformOutput', false), 'Location', 'northwest');
if cfg.savePlots
    save_project_figure(figureHandle, cfg.plotDirectory, '03_capacity_threshold_analysis.png');
end
