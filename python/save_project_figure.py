"""
=========================================================================================================================
 *** save_project_figure.py ***
 Figure export helper.
=========================================================================================================================

Description:
    Creates the output folder when required and exports a matplotlib figure at 150 dpi, so every analysis
    writes result files through one consistent path. Mirrors matlab/save_project_figure.m.

Input:
    figure, outputDirectory, fileName
=========================================================================================================================
"""
import os


def save_project_figure(figure, outputDirectory, fileName):
    os.makedirs(outputDirectory, exist_ok=True)
    figure.savefig(os.path.join(outputDirectory, fileName), dpi=150)
