"""
=========================================================================================================================
 *** run_radius_vs_node_count.py ***
 Radius versus node count.
=========================================================================================================================

Description:
    Deploys the candidate nodes over the service area (seeded), calculates their distances from the reference
    location, and evaluates the number of available nodes over the coverage-radius sweep. The regression checks
    run first and the script stops if any check fails. Mirrors matlab/run_radius_vs_node_count.m.

Output:
    stdout                    Node counts at selected radii against the closed-form expectation.
    figures/01_radius_vs_node_count.png
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

    positions_m = generate_node_positions(rng, cfg['numberOfCandidateNodes'],
                                          cfg['areaLength_m'], cfg['areaWidth_m'])
    distances_m = calculate_distances(positions_m, cfg['centerPosition_m'])
    nodeCount = count_nodes_within_radius(distances_m, cfg['radiusVector_m'])

    fig, ax = plt.subplots(figsize=(8.5, 5.2))
    ax.plot(cfg['radiusVector_m'], nodeCount, '-o', ms=4)
    ax.grid(alpha=0.3); ax.set_xlabel('Coverage radius (m)')
    ax.set_ylabel('Number of available nodes')
    ax.set_title('Available nodes versus coverage radius')
    if cfg['savePlots']:
        save_project_figure(fig, cfg['plotDirectory'], '01_radius_vs_node_count.png')

    for R in (50, 100, 200):
        i = int(np.where(cfg['radiusVector_m'] == R)[0][0])
        expected = cfg['numberOfCandidateNodes']*np.pi*R**2/(cfg['areaLength_m']*cfg['areaWidth_m'])
        print(f'  R = {R:3d} m: {nodeCount[i]} nodes (expected {expected:.1f})')


if __name__ == '__main__':
    main()
