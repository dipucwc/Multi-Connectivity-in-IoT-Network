"""
=========================================================================================================================
 *** run_density_vs_node_count.py ***
 Node density versus coverage count.
=========================================================================================================================

Description:
    Sweeps the deployed node count (seeded), computes the density lambda = n / (L W), and evaluates the number
    of nodes inside a fixed 100 m radius. The count grows linearly with lambda; the closed-form expectation
    lambda pi R^2 is overlaid. Mirrors matlab/run_density_vs_node_count.m.

Output:
    figures/02_density_vs_node_count.png
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
from count_nodes_within_radius import count_nodes_within_radius
from save_project_figure import save_project_figure


def main():
    cfg = default_parameters()
    if not verify_model():
        raise SystemExit('Regression checks failed.')
    rng = np.random.default_rng(cfg['randomSeed'])

    R = 100.0
    lam = cfg['nodeCountVector'] / (cfg['areaLength_m']*cfg['areaWidth_m'])
    countInRadius = []
    for n in cfg['nodeCountVector']:
        pos = generate_node_positions(rng, int(n), cfg['areaLength_m'], cfg['areaWidth_m'])
        countInRadius.append(count_nodes_within_radius(
            calculate_distances(pos, cfg['centerPosition_m']), R)[0])

    fig, ax = plt.subplots(figsize=(8.5, 5.2))
    ax.plot(lam, countInRadius, '-o', ms=4)
    ax.plot(lam, lam*np.pi*R**2, 'k--')              # closed-form expectation lambda*pi*R^2
    ax.grid(alpha=0.3); ax.set_xlabel('Node density $\\lambda$ (nodes/m$^2$)')
    ax.set_ylabel(f'Nodes within R = {R:.0f} m')
    ax.set_title('Coverage count versus node density')
    ax.legend(['Seeded deployment', 'Expectation $\\lambda\\pi R^2$'], loc='upper left')
    if cfg['savePlots']:
        save_project_figure(fig, cfg['plotDirectory'], '02_density_vs_node_count.png')


if __name__ == '__main__':
    main()
