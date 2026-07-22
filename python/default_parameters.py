"""
=========================================================================================================================
 *** default_parameters.py ***
 Central configuration of the multi-connectivity IoT study.
=========================================================================================================================

Description:
    Normalized model units carried over from the original scripts: transmit powers and the noise power are
    dimensionless (N0 = 1), the bandwidth constant W = 100 scales the Shannon capacity, and distances are in
    metres over a 1000 x 1000 m service area. Every analysis and the regression checks read this one structure;
    the seed makes every random deployment and Monte Carlo run reproducible. Mirrors matlab/default_parameters.m
    value for value. The capacity thresholds are matched to the capacity scale of the geometry (C ~ 721/d^2,
    about 0.07 at 100 m); 200000 Monte Carlo trials resolve outage down to about 1e-5.

Output:
    default_parameters()    Dictionary with reproducibility, geometry, sweep, capacity-model, reliability,
                            Monte Carlo, numerical-protection, and plot-output settings.
=========================================================================================================================
"""
import os
import numpy as np


def default_parameters():
    here = os.path.dirname(os.path.abspath(__file__))
    return {
        'randomSeed': 7,
        'areaLength_m': 1000.0, 'areaWidth_m': 1000.0,
        'centerPosition_m': np.array([500.0, 500.0]),
        'numberOfCandidateNodes': 1000,
        'radiusVector_m': np.arange(10, 251, 10, dtype=float),
        'nodeCountVector': np.arange(100, 1001, 100),
        'bandwidth_Hz': 100.0, 'noisePower': 1.0,
        'pathLossExponentVector': (2.0, 4.0),
        'referenceTransmitPower': 5.0,
        'remoteTransmitPowerVector': np.arange(1, 11, dtype=float),
        'capacityThresholdVector': (0.05, 0.10, 0.20),
        'linkAvailabilityVector': np.arange(0.80, 0.9991, 0.01),
        'connectivityOrderVector': (1, 2, 3),
        'monteCarloRuns': 200000,
        'minimumDistance_m': 1e-3,
        'savePlots': True,
        'plotDirectory': os.path.join(here, 'figures'),
    }
