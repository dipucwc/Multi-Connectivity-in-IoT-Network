"""
=========================================================================================================================
 *** calculate_link_capacity.py ***
 Interference-limited link capacity.
=========================================================================================================================

Description:
    Shannon-style capacity of one link under path loss, integrated noise, and aggregate interference:
    SINR = P_s d_s^-alpha / (N0 + sum P_i d_i^-alpha), C = W log2(1 + SINR). The original scripts used the
    natural logarithm; log2 is used here so the result reads in bit/s when W is in hertz (a constant factor
    1/ln 2, monotonic behavior unchanged). Normalized units of default_parameters. Distances below
    minimumDistance_m are clamped for numerical stability. Mirrors matlab/calculate_link_capacity.m.

Input:
    desiredPower, desiredDistance_m, interferencePower, interferenceDistance_m,
    bandwidth_Hz, noisePower, pathLossExponent, minimumDistance_m

Output:
    calculate_link_capacity()    Link capacity (normalized units here).
=========================================================================================================================
"""
import numpy as np


def calculate_link_capacity(desiredPower, desiredDistance_m, interferencePower,
                            interferenceDistance_m, bandwidth_Hz, noisePower,
                            pathLossExponent, minimumDistance_m):
    ds = max(desiredDistance_m, minimumDistance_m)
    di = np.maximum(np.asarray(interferenceDistance_m, float), minimumDistance_m)
    desiredReceivedPower = desiredPower * ds**(-pathLossExponent)
    aggregateInterference = np.sum(np.asarray(interferencePower, float) * di**(-pathLossExponent))
    sinrLinear = desiredReceivedPower / (noisePower + aggregateInterference)
    return bandwidth_Hz * np.log2(1.0 + sinrLinear)
