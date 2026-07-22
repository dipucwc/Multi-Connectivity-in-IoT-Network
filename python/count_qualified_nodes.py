"""
=========================================================================================================================
 *** count_qualified_nodes.py ***
 Jointly qualified node count under radius and capacity conditions.
=========================================================================================================================

Description:
    Counts nodes that satisfy the coverage-radius and minimum-capacity conditions simultaneously, per radius
    value. Used to study how many candidate serving nodes remain under joint geometric and link-quality
    constraints. Mirrors matlab/count_qualified_nodes.m.

Input:
    distances_m, nodeCapacity, radiusVector_m, capacityThreshold

Output:
    count_qualified_nodes()    Qualified node count for each radius.
=========================================================================================================================
"""
import numpy as np


def count_qualified_nodes(distances_m, nodeCapacity, radiusVector_m, capacityThreshold):
    d = np.asarray(distances_m, float).reshape(-1, 1)
    C = np.asarray(nodeCapacity, float).reshape(-1, 1)
    R = np.asarray(radiusVector_m, float).reshape(1, -1)
    return np.sum((d <= R) & (C >= capacityThreshold), axis=0)
