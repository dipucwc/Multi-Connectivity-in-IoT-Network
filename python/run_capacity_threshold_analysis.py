"""
=========================================================================================================================
 *** run_capacity_threshold_analysis.py ***
 Coverage under joint radius and capacity constraints.
=========================================================================================================================

Description:
    Deploys the candidate nodes (seeded), assigns every node the interference-limited capacity of its link to
    the reference point (one common interferer geometry), and evaluates how many nodes satisfy the coverage
    radius and a minimum-capacity threshold simultaneously, for each threshold of the configuration. The
    thresholds are matched to the capacity scale of the geometry (C ~ 721/d^2 normalized, about 0.07 at 100 m),
    so the curves separate and saturate near the threshold-limited distances of roughly 120, 85, and 60 m.
    Mirrors matlab/run_capacity_threshold_analysis.m.

Output:
    figures/03_capacity_threshold_analysis.png
=========================================================================================================================
"""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from default_parameters import default_parameters
from verify_model import verify_model
from generate_node_positions import generate_node_positions
from calculate_distances import calculate_distances
from calculate_link_capacity import calculate_link_capacity
from count_qualified_nodes import count_qualified_nodes
from save_project_figure import save_project_figure


def main():
    cfg = default_parameters()
    if not verify_model():
        raise SystemExit('Regression checks failed.')
    rng = np.random.default_rng(cfg['randomSeed'])

    positions_m = generate_node_positions(rng, cfg['numberOfCandidateNodes'],
                                          cfg['areaLength_m'], cfg['areaWidth_m'])
    distances_m = calculate_distances(positions_m, cfg['centerPosition_m'])

    interfererDistance_m = 200.0                     # one fixed interferer geometry for the whole sweep
    nodeCapacity = np.array([calculate_link_capacity(
        cfg['referenceTransmitPower'], d, 1, interfererDistance_m,
        cfg['bandwidth_Hz'], cfg['noisePower'], 2, cfg['minimumDistance_m'])
        for d in distances_m])

    fig, ax = plt.subplots(figsize=(8.5, 5.2))
    for Cth, mk in zip(cfg['capacityThresholdVector'], ('-o', '-s', '-^')):
        q = count_qualified_nodes(distances_m, nodeCapacity, cfg['radiusVector_m'], Cth)
        ax.plot(cfg['radiusVector_m'], q, mk, ms=3, label=f'C_th = {Cth:.2f}')
    ax.grid(alpha=0.3); ax.set_xlabel('Coverage radius (m)'); ax.set_ylabel('Qualified nodes')
    ax.set_title('Nodes meeting radius and capacity conditions'); ax.legend()
    if cfg['savePlots']:
        save_project_figure(fig, cfg['plotDirectory'], '03_capacity_threshold_analysis.png')


if __name__ == '__main__':
    main()
