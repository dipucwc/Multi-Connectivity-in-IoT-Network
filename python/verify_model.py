"""
=========================================================================================================================
 *** verify_model.py ***
 Regression checks of the model functions.
=========================================================================================================================

Description:
    Deterministic and statistical checks of the model chain, identical to matlab/verify_model.m. Deterministic:
    distances on a 3-4-5 geometry; radius counting on a fixed vector; the availability closed forms
    0.9 / 0.99 / 0.999 at p = 0.9 for K = 1, 2, 3; and one exact capacity value,
    C = 100 log2(1 + (5/16)/(1 + 1/64)) = 38.702 in normalized units for P_s = 5, d_s = 4, P_i = 1, d_i = 8,
    alpha = 2. Statistical: the seeded mean node count inside R = 100 m over the 1000 x 1000 m area with 1000
    nodes must lie within five standard errors of the closed-form expectation n pi R^2 / L^2 = 31.42.

Output:
    verify_model()    True when every check passes.
=========================================================================================================================
"""
import numpy as np
from default_parameters import default_parameters
from generate_node_positions import generate_node_positions
from calculate_distances import calculate_distances
from count_nodes_within_radius import count_nodes_within_radius
from calculate_link_capacity import calculate_link_capacity
from calculate_multiconnectivity_availability import calculate_multiconnectivity_availability


def verify_model():
    cfg = default_parameters()
    ok = True
    print('Regression checks:')

    def check(name, cond):
        nonlocal ok
        print(f"  [{'OK  ' if cond else 'FAIL'}] {name}")
        ok = ok and cond

    d = calculate_distances([[0, 0], [3, 4], [6, 8]], [0, 0])
    check('distances 3-4-5 geometry', np.max(np.abs(d - [0, 5, 10])) < 1e-12)

    c = count_nodes_within_radius([1, 2, 5, 8], [2, 5, 10])
    check('radius counting', np.array_equal(c, [2, 3, 4]))

    a = [calculate_multiconnectivity_availability(0.9, K) for K in (1, 2, 3)]
    check('availability closed forms',
          abs(a[0]-0.9) < 1e-12 and abs(a[1]-0.99) < 1e-12 and abs(a[2]-0.999) < 1e-12)

    cap = calculate_link_capacity(5, 4, 1, 8, cfg['bandwidth_Hz'], cfg['noisePower'], 2,
                                  cfg['minimumDistance_m'])
    capExpected = 100*np.log2(1 + (5/16)/(1 + 1/64))
    check(f'capacity exact value ({capExpected:.3f})', abs(cap - capExpected) < 1e-9)

    rng = np.random.default_rng(cfg['randomSeed'])
    R, trials = 100.0, 200
    counts = np.array([count_nodes_within_radius(calculate_distances(
        generate_node_positions(rng, cfg['numberOfCandidateNodes'],
                                cfg['areaLength_m'], cfg['areaWidth_m']),
        cfg['centerPosition_m']), R)[0] for _ in range(trials)])
    expected = cfg['numberOfCandidateNodes']*np.pi*R**2/(cfg['areaLength_m']*cfg['areaWidth_m'])
    check(f'mean node count vs n*pi*R^2/L^2 ({expected:.2f})',
          abs(counts.mean() - expected) < 5*counts.std()/np.sqrt(trials))

    print('  All regression checks passed.\n' if ok else '  Regression checks FAILED.\n')
    return ok
