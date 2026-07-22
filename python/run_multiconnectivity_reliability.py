"""
=========================================================================================================================
 *** run_multiconnectivity_reliability.py ***
 Multi-connectivity reliability.
=========================================================================================================================

Description:
    Compares the analytical availability 1 - (1 - p)^K for single, dual, and triple connectivity over the
    link-availability sweep, with seeded Monte Carlo trials as a numerical cross-check at selected values. The
    Monte Carlo markers must lie on the analytical curves; at p = 0.9 the closed-form values are 0.9, 0.99, and
    0.999. With 200000 trials the estimator resolves outage down to about 1e-5; points with analytical outage
    below that (K = 3 at p = 0.99, outage 1e-6) are shown as gaps rather than quantization artifacts. Mirrors
    matlab/run_multiconnectivity_reliability.m.

Output:
    stdout                    Analytical and Monte Carlo availability at p = 0.9.
    figures/05_multiconnectivity_reliability.png
=========================================================================================================================
"""
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from default_parameters import default_parameters
from verify_model import verify_model
from calculate_multiconnectivity_availability import calculate_multiconnectivity_availability
from save_project_figure import save_project_figure


def main():
    cfg = default_parameters()
    if not verify_model():
        raise SystemExit('Regression checks failed.')
    rng = np.random.default_rng(cfg['randomSeed'])

    p = cfg['linkAvailabilityVector']
    fig, ax = plt.subplots(figsize=(8.5, 5.2))
    for K in cfg['connectivityOrderVector']:
        ax.semilogy(p, 1 - calculate_multiconnectivity_availability(p, K), label=f'K = {K}')

    pSel = np.array([0.85, 0.90, 0.95, 0.99])
    for K in cfg['connectivityOrderVector']:
        trials = rng.random((len(pSel), cfg['monteCarloRuns'], K)) < pSel.reshape(-1, 1, 1)
        Amc = trials.any(axis=2).mean(axis=1)
        out = 1.0 - Amc
        out[out < 2/cfg['monteCarloRuns']] = np.nan   # below estimator resolution: gap, not artifact
        ax.semilogy(pSel, out, 'k^', ms=6)
        print(f'  K = {K} @ p = 0.90: analytical '
              f'{calculate_multiconnectivity_availability(0.9, K):.4f}, Monte Carlo {Amc[1]:.4f}')

    ax.grid(alpha=0.3, which='both'); ax.set_xlabel('Individual-link availability p')
    ax.set_ylabel('Outage probability 1 - A')
    ax.set_title('Outage versus link availability for K = 1, 2, 3')
    ax.legend(loc='lower left')
    if cfg['savePlots']:
        save_project_figure(fig, cfg['plotDirectory'], '05_multiconnectivity_reliability.png')


if __name__ == '__main__':
    main()
