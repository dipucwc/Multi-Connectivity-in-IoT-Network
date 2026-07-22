%%
%% Complete Workflow:
%%
%{
Runs the regression checks and all five analyses in sequence, exporting every figure to the plots
folder. Each analysis can also be run individually.

Output:

    Command Window and plots/01..05 figure files.
%}


%% Sequence:
%%

clc; close all;
here = fileparts(mfilename('fullpath'));
addpath(here);

run_radius_vs_node_count;
run_density_vs_node_count;
run_capacity_threshold_analysis;
run_power_vs_capacity;
run_multiconnectivity_reliability;
fprintf('All analyses completed.\n');
