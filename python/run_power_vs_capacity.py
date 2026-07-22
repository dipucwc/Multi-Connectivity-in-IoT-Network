"""
=========================================================================================================================
 *** run_power_vs_capacity.py ***
 Transmit power versus link capacity.
=========================================================================================================================

Description:
    Evaluates the interference-limited link capacity over the remote transmit-power sweep for both path-loss
    exponents, on one fixed desired and interference geometry (d_s = 4 m, d_i = 8 m) so the curves are compared
    under identical conditions. Expected values, printed by the script: C(P = 5) = 36.721 for alpha = 2 and
    2.787 for alpha = 4 in normalized units. Mirrors matlab/run_power_vs_capacity.m.

Output:
    stdout                    Capacity at P = 5 for both exponents.
    figures/04_power_vs_capacity.png
=========================================================================================================================
"""
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from default_parameters import default_parameters
from verify_model import verify_model
from calculate_link_capacity import calculate_link_capacity
from save_project_figure import save_project_figure


def main():
    cfg = default_parameters()
    if not verify_model():
        raise SystemExit('Regression checks failed.')

    desiredDistance_m, interferenceDistance_m = 4.0, 8.0
    P = cfg['remoteTransmitPowerVector']
    fig, ax = plt.subplots(figsize=(8.5, 5.2))
    for alpha, mk in zip(cfg['pathLossExponentVector'], ('-o', '-x')):
        C = [calculate_link_capacity(pp, desiredDistance_m, cfg['referenceTransmitPower'],
             interferenceDistance_m, cfg['bandwidth_Hz'], cfg['noisePower'], alpha,
             cfg['minimumDistance_m']) for pp in P]
        ax.plot(P, C, mk)
        print(f'  alpha = {alpha:g}: C(P = 5) = {C[4]:.3f}')
    ax.grid(alpha=0.3); ax.set_xlabel('Remote transmit power (normalized)')
    ax.set_ylabel('Link capacity (normalized)')
    ax.set_title('Link capacity versus remote transmit power')
    ax.legend(['alpha = 2', 'alpha = 4'], loc='upper left')
    if cfg['savePlots']:
        save_project_figure(fig, cfg['plotDirectory'], '04_power_vs_capacity.png')


if __name__ == '__main__':
    main()
