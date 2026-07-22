"""
=========================================================================================================================
 *** count_nodes_within_radius.py ***
 Node count per coverage radius.
=========================================================================================================================

Description:
    Counts how many candidate nodes lie inside every value of the radius vector. For a uniform deployment of
    n nodes over an L x L area, the expected count inside radius R is n pi R^2 / L^2, which the regression
    checks use as a closed-form reference. Mirrors matlab/count_nodes_within_radius.m.

Input:
    distances_m, radiusVector_m

Output:
    count_nodes_within_radius()    Number of nodes inside each radius.
=========================================================================================================================
"""
import numpy as np


def count_nodes_within_radius(distances_m, radiusVector_m):
    d = np.asarray(distances_m, float).reshape(-1, 1)
    R = np.asarray(radiusVector_m, float).reshape(1, -1)
    return np.sum(d <= R, axis=0)          # vectorized N x R comparison
