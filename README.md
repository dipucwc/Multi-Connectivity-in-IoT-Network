# Multi-Connectivity in IoT Networks

**MATLAB and Python modeling of IoT coverage, node density, interference-aware capacity, multi-connectivity reliability, and Monte Carlo verification**

---

## Project Overview

This project presents an analytical and simulation-based study of multi-connectivity in IoT networks.

The implementation evaluates how network performance changes with:

- coverage radius;
- node density;
- available-node count;
- transmit power;
- propagation conditions;
- link-capacity thresholds;
- single, dual, and triple connectivity;
- individual-link availability;
- outage probability.

The project is implemented independently in MATLAB and Python. Both implementations include regression checks, seeded simulations, analytical models, Monte Carlo verification, and automatic plot generation.

---

## Project Origin

This work originated from wireless-system modeling and simulation activities at the Centre for Wireless Communications, University of Oulu.

The original project studied node availability, coverage radius, capacity, transmit power, and multi-connectivity behavior in IoT networks. The current repository develops that work into a modular MATLAB and Python package with clearer models, reusable functions, reproducible simulations, regression testing, and multi-connectivity reliability analysis.

---

## Main Objectives

1. Evaluate the number of available IoT nodes over a coverage-radius sweep.
2. Compare simulated node counts with theoretical spatial-density expectations.
3. Evaluate normalized link capacity under interference.
4. Count nodes satisfying both coverage and minimum-capacity conditions.
5. Compare single, dual, and triple connectivity.
6. Evaluate outage probability over a link-availability sweep.
7. Verify analytical reliability results using seeded Monte Carlo simulation.
8. Reproduce selected model values using regression checks.
9. Cross-check the implementation independently in MATLAB and Python.
10. Present the complete study as a reproducible wireless-system simulation project.

---

## System Model

### Node Deployment

Candidate nodes are distributed uniformly over a rectangular service area.

```text
lambda = N / L^2
```

```text
E[N_R] = lambda × pi × R^2
```

where:

- N is the total number of deployed nodes;
- lambda is the node density in nodes per square metre;
- L^2 is the service-area size;
- R is the circular coverage radius.

The simulated node count is compared with this theoretical expectation.

### Distance Calculation

```text
d = sqrt((x - x0)^2 + (y - y0)^2)
```

A node is counted inside the selected coverage region when:

```text
d <= R
```

### Interference-Aware Link Capacity

```text
P_received = P_s × d_s^(-alpha)
```

```text
I = sum(P_i × d_i^(-alpha))
```

```text
SINR = (P_s × d_s^(-alpha)) / (N_0 + sum(P_i × d_i^(-alpha)))
```

```text
C = W × log2(1 + SINR)
```

where:

- P_s is the desired-link transmit power;
- d_s is the desired-link distance;
- P_i is an interfering transmit power;
- d_i is an interference-link distance;
- alpha is the path-loss exponent;
- N_0 is the integrated noise value;
- W is the channel bandwidth.

The capacity model uses normalized power and noise parameters. Therefore, the results represent comparative system behavior rather than calibrated physical throughput.

### Coverage and Capacity Qualification

A node is qualified when it satisfies both:

```text
distance <= coverage radius
```

and:

```text
capacity > capacity threshold
```

The configured capacity thresholds are:

```text
0.05
0.10
0.20
```

### Multi-Connectivity Reliability

For K statistically independent candidate links with equal individual-link availability p:

```text
A_K = 1 - (1 - p)^K
```

The outage probability is:

```text
P_out = (1 - p)^K
```

The project compares:

```text
K = 1  Single connectivity
K = 2  Dual connectivity
K = 3  Triple connectivity
```

The analytical reliability model assumes statistically independent serving-link failures.

---

## MATLAB and Python Implementation

The repository contains independent MATLAB and Python implementations of the same main analytical and simulation workflow.

### MATLAB

The MATLAB package includes:

- centralized parameters;
- node-position generation;
- Euclidean distance calculation;
- radius-based node counting;
- normalized link-capacity calculation;
- joint coverage and capacity qualification;
- multi-connectivity availability calculation;
- Monte Carlo reliability verification;
- regression checks;
- automatic plot export.

### Python

The Python package independently reproduces:

- node deployment;
- coverage-radius analysis;
- density analysis;
- normalized capacity analysis;
- capacity-threshold analysis;
- multi-connectivity reliability;
- seeded Monte Carlo verification;
- regression checks;
- figure generation.

The use of both environments supports reproducibility and MATLAB-Python cross-verification.

---

## Repository Structure

```text
Multi-Connectivity-in-IoT-Network/
├── README.md
├── .gitignore
├── matlab/
│   ├── calculate_distances.m
│   ├── calculate_link_capacity.m
│   ├── calculate_multiconnectivity_availability.m
│   ├── count_nodes_within_radius.m
│   ├── count_qualified_nodes.m
│   ├── default_parameters.m
│   ├── generate_node_positions.m
│   ├── run_all_analyses.m
│   ├── run_capacity_threshold_analysis.m
│   ├── run_density_vs_node_count.m
│   ├── run_multiconnectivity_reliability.m
│   ├── run_power_vs_capacity.m
│   ├── run_radius_vs_node_count.m
│   ├── save_project_figure.m
│   ├── verify_model.m
│   └── README.md
├── python/
│   ├── calculate_distances.py
│   ├── calculate_link_capacity.py
│   ├── calculate_multiconnectivity_availability.py
│   ├── count_nodes_within_radius.py
│   ├── count_qualified_nodes.py
│   ├── default_parameters.py
│   ├── generate_node_positions.py
│   ├── run_all_analyses.py
│   ├── run_capacity_threshold_analysis.py
│   ├── run_density_vs_node_count.py
│   ├── run_multiconnectivity_reliability.py
│   ├── run_power_vs_capacity.py
│   ├── run_radius_vs_node_count.py
│   ├── save_project_figure.py
│   ├── verify_model.py
│   └── README.md
├── plots/
│   ├── 01_radius_vs_node_count.png
│   ├── 02_density_vs_node_count.png
│   ├── 03_capacity_threshold_analysis.png
│   ├── 04_power_vs_capacity.png
│   ├── 05_multiconnectivity_reliability.png
│   └── README.md
└── legacy/
    └── original MATLAB implementation
```

---

## How to Run

### MATLAB

```matlab
cd matlab
verify_model
run_all_analyses
```

Individual analyses:

```matlab
run_radius_vs_node_count
run_density_vs_node_count
run_capacity_threshold_analysis
run_power_vs_capacity
run_multiconnectivity_reliability
```

### Python

Install dependencies:

```bash
pip install numpy matplotlib
```

Run the complete workflow:

```bash
cd python
python verify_model.py
python run_all_analyses.py
```

Individual analyses:

```bash
python run_radius_vs_node_count.py
python run_density_vs_node_count.py
python run_capacity_threshold_analysis.py
python run_power_vs_capacity.py
python run_multiconnectivity_reliability.py
```

---

## Regression Checks

Both implementations include selected analytical and statistical checks:

```text
[OK] distances 3-4-5 geometry
[OK] radius counting
[OK] availability closed forms
[OK] capacity exact value (38.702)
[OK] mean node count versus n × pi × R^2 / L^2
```

The regression suite verifies:

- Euclidean distance calculation;
- radius-based node counting;
- single-, dual-, and triple-connectivity closed forms;
- one exact normalized capacity value;
- agreement between simulated mean node count and theoretical expectation.

---

## Selected Results

### Coverage Radius

```text
R = 50 m:   7 nodes, expected 7.9
R = 100 m: 32 nodes, expected 31.4
R = 200 m: 123 nodes, expected 125.7
```

The available-node count increases with coverage radius and follows the expected spatial trend.

### Capacity Behavior

For remote transmit power P = 5:

```text
alpha = 2: C = 36.721
alpha = 4: C = 2.787
```

The larger path-loss exponent produces lower normalized link capacity under the selected model conditions.

### Multi-Connectivity Reliability

At individual-link availability p = 0.90:

| Connectivity | Analytical availability |
|---|---:|
| Single connectivity, K = 1 | 0.9000 |
| Dual connectivity, K = 2 | 0.9900 |
| Triple connectivity, K = 3 | 0.9990 |

The seeded Monte Carlo results closely follow the analytical values.

---

## Generated Plots

### `01_radius_vs_node_count.png`

Shows how the number of available nodes increases with coverage radius.

### `02_density_vs_node_count.png`

Compares the seeded deployment with the theoretical density-based expectation.

### `03_capacity_threshold_analysis.png`

Shows the number of nodes satisfying both coverage and normalized capacity conditions.

### `04_power_vs_capacity.png`

Compares normalized capacity for path-loss exponents alpha = 2 and alpha = 4.

### `05_multiconnectivity_reliability.png`

Shows analytical outage for K = 1, 2, and 3 with Monte Carlo verification markers.

---

## Main Findings

The study demonstrates that:

1. increasing coverage radius increases the number of candidate serving nodes;
2. simulated node counts follow the theoretical density-based expectation;
3. higher path loss reduces normalized link capacity;
4. stricter capacity thresholds reduce the number of qualified nodes;
5. dual connectivity provides substantially lower outage than single connectivity;
6. triple connectivity provides a further reliability improvement;
7. seeded Monte Carlo results verify the analytical independent-link model;
8. MATLAB and Python implementations provide consistent and reproducible analysis.

---

## Technical Skills Demonstrated

- wireless-system modeling;
- IoT network analysis;
- multi-connectivity reliability;
- coverage modeling;
- spatial node-density analysis;
- interference-aware SINR modeling;
- normalized Shannon-style capacity analysis;
- Monte Carlo simulation;
- regression testing;
- MATLAB development;
- Python numerical implementation;
- cross-language verification;
- technical plotting and documentation.

---

## Model Scope

The current model includes:

- uniform random node deployment;
- circular coverage regions;
- normalized power and noise values;
- distance-dependent attenuation;
- statistically independent link failures;
- fixed connectivity orders;
- seeded Monte Carlo verification.

The current model does not include:

- correlated failures;
- device mobility;
- traffic queues;
- packet-level protocol simulation;
- heterogeneous radio technologies;
- shared backhaul failures;
- calibrated hardware throughput;
- latency or battery-energy models.

---

## Future Work

Possible extensions include:

- correlated multi-link failure models;
- capacity sharing among connected devices;
- traffic-load and queueing analysis;
- heterogeneous connectivity using BLE, Wi-Fi, LTE-M, and NB-IoT;
- latency-aware and energy-aware link selection;
- mobility and handover;
- reliability-aware node association;
- optimization of coverage, capacity, and connectivity order.

---

## Author

**Md Moklesur Rahman**

Wireless communication, RF/PHY systems, MATLAB, Python, IoT network modeling, and simulation.

- GitHub: [dipucwc](https://github.com/dipucwc)
- LinkedIn: [Md Moklesur Rahman](https://www.linkedin.com/in/md-moklesur-rahman-65a63962/)
