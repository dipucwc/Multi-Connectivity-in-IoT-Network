"""
=========================================================================================================================
 *** run_all_analyses.py ***
 Complete workflow.
=========================================================================================================================

Description:
    Runs the five analyses in sequence (each begins with the regression checks and stops if any check fails),
    exporting every figure to the figures folder. Each analysis can also be run individually. Mirrors
    matlab/run_all_analyses.m.

Output:
    stdout and figures/01..05 png files.
=========================================================================================================================
"""
import run_radius_vs_node_count
import run_density_vs_node_count
import run_capacity_threshold_analysis
import run_power_vs_capacity
import run_multiconnectivity_reliability


def main():
    run_radius_vs_node_count.main()
    run_density_vs_node_count.main()
    run_capacity_threshold_analysis.main()
    run_power_vs_capacity.main()
    run_multiconnectivity_reliability.main()
    print('All analyses completed.')


if __name__ == '__main__':
    main()
