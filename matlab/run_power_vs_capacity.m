%%
%% Transmit Power versus Link Capacity:
%%
%{
Evaluates the interference-limited link capacity over the remote transmit-power sweep for both path-loss
exponents, on one fixed desired and interference geometry (d_s = 4 m, d_i = 8 m) so the curves are
compared under identical conditions. Reproduces the legacy PrVsCrr study with the log2 capacity
definition. Expected values, printed by the script: C(P = 5) = 36.721 for alpha = 2 and 2.787 for
alpha = 4 in normalized units.

Auxiliary functions:

    default_parameters, verify_model, calculate_link_capacity, save_project_figure

Output:

    Command Window            Capacity at P = 5 for both exponents.
    plots/04_power_vs_capacity.png
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

%% Power sweep over both exponents:
%%

desiredDistance_m = 4; interferenceDistance_m = 8;
P = cfg.remoteTransmitPowerVector;
C = zeros(numel(cfg.pathLossExponentVector), numel(P));
for e = 1:numel(cfg.pathLossExponentVector)
    for k = 1:numel(P)
        C(e, k) = calculate_link_capacity(P(k), desiredDistance_m, ...
            cfg.referenceTransmitPower, interferenceDistance_m, ...
            cfg.bandwidth_Hz, cfg.noisePower, cfg.pathLossExponentVector(e), ...
            cfg.minimumDistance_m);
    end
    fprintf('  alpha = %g: C(P = 5) = %.3f\n', cfg.pathLossExponentVector(e), C(e, P == 5));
end

figureHandle = figure('Name', 'Power versus Capacity', 'NumberTitle', 'off');
plot(P, C(1, :), '-o', P, C(2, :), '-x', 'LineWidth', 1.2);
grid on; xlabel('Remote transmit power (normalized)'); ylabel('Link capacity (normalized)');
title('Link capacity versus remote transmit power');
legend('\alpha = 2', '\alpha = 4', 'Location', 'northwest');
if cfg.savePlots
    save_project_figure(figureHandle, cfg.plotDirectory, '04_power_vs_capacity.png');
end
