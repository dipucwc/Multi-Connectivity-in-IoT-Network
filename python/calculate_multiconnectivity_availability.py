"""
=========================================================================================================================
 *** calculate_multiconnectivity_availability.py ***
 Multi-connectivity availability.
=========================================================================================================================

Description:
    Probability that at least one of K candidate serving links is available under statistically independent
    link failures: A = 1 - (1 - p)^K. K = 1, 2, 3 gives single, dual, and triple connectivity; for p = 0.9 the
    closed-form values are 0.9, 0.99, and 0.999, which the regression checks reproduce. Mirrors
    matlab/calculate_multiconnectivity_availability.m.

Input:
    linkAvailability (in [0, 1]), connectivityOrder K

Output:
    calculate_multiconnectivity_availability()    Availability, same shape as linkAvailability.
=========================================================================================================================
"""
import numpy as np


def calculate_multiconnectivity_availability(linkAvailability, connectivityOrder):
    return 1.0 - (1.0 - np.asarray(linkAvailability, float))**connectivityOrder
