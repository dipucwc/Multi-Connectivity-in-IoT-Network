"""
=========================================================================================================================
 *** generate_node_positions.py ***
 Uniform node deployment over the rectangular service area.
=========================================================================================================================

Description:
    Two-dimensional node locations uniformly distributed over the service area. All coverage, density, capacity,
    and reliability studies reuse this one deployment utility; the caller supplies the seeded generator, so a
    deployment is reproducible per run script. Mirrors matlab/generate_node_positions.m.

Input:
    rng, numberOfNodes, areaLength_m, areaWidth_m

Output:
    generate_node_positions()    Node coordinates, numberOfNodes by 2, in metres.
=========================================================================================================================
"""
import numpy as np


def generate_node_positions(rng, numberOfNodes, areaLength_m, areaWidth_m):
    return np.column_stack([rng.random(numberOfNodes) * areaLength_m,
                            rng.random(numberOfNodes) * areaWidth_m])
