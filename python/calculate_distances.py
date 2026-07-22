"""
=========================================================================================================================
 *** calculate_distances.py ***
 Euclidean distances from every node to a reference point.
=========================================================================================================================

Description:
    Distance from every node position to one reference coordinate, used by the radius, coverage, and
    node-qualification analyses. Mirrors matlab/calculate_distances.m.

Input:
    nodePositions_m (N by 2), referencePosition_m (1 by 2)

Output:
    calculate_distances()    Distance vector in metres, length N.
=========================================================================================================================
"""
import numpy as np


def calculate_distances(nodePositions_m, referencePosition_m):
    offsets = np.asarray(nodePositions_m, float) - np.asarray(referencePosition_m, float).reshape(1, 2)
    return np.sqrt(np.sum(offsets**2, axis=1))
