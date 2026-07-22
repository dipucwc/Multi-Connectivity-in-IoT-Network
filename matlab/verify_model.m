function ok = verify_model()
%%
%% Regression Checks of the Model Functions:
%%
%{
Deterministic and statistical checks of the model chain. Deterministic: distances on a 3-4-5 geometry;
radius counting on a fixed vector; the availability closed forms 0.9 / 0.99 / 0.999 at p = 0.9 for
K = 1, 2, 3; and one exact capacity value, C = 100 log2(1 + (5/16)/(1 + 1/64)) = 38.702 in normalized
units for P_s = 5, d_s = 4, P_i = 1, d_i = 8, alpha = 2. Statistical: the seeded mean node count inside
R = 100 m over the 1000 x 1000 m area with 1000 nodes must lie within five standard errors of the
closed-form expectation n pi R^2 / L^2 = 31.42. The same checks run in the Python mirror.

Output:

    ok           True when every check passes.
%}

ok = true;
cfg = default_parameters();
fprintf('Regression checks:\n');

%% Deterministic checks:
%%

d = calculate_distances([0 0; 3 4; 6 8], [0 0]);
ok = check(ok, 'distances 3-4-5 geometry', max(abs(d - [0; 5; 10])) < 1e-12);

c = count_nodes_within_radius([1; 2; 5; 8], [2, 5, 10]);
ok = check(ok, 'radius counting', isequal(c, [2, 3, 4]));

a1 = calculate_multiconnectivity_availability(0.9, 1);
a2 = calculate_multiconnectivity_availability(0.9, 2);
a3 = calculate_multiconnectivity_availability(0.9, 3);
ok = check(ok, 'availability closed forms', ...
    abs(a1-0.9) < 1e-12 && abs(a2-0.99) < 1e-12 && abs(a3-0.999) < 1e-12);

cap = calculate_link_capacity(5, 4, 1, 8, cfg.bandwidth_Hz, cfg.noisePower, 2, cfg.minimumDistance_m);
capExpected = 100*log2(1 + (5/16)/(1 + 1/64));
ok = check(ok, sprintf('capacity exact value (%.3f)', capExpected), abs(cap - capExpected) < 1e-9);

%% Statistical check against the closed-form expectation:
%%

rng(cfg.randomSeed, 'twister');
R = 100; trials = 200; counts = zeros(1, trials);
for t = 1:trials
    pos = generate_node_positions(cfg.numberOfCandidateNodes, cfg.areaLength_m, cfg.areaWidth_m);
    counts(t) = count_nodes_within_radius(calculate_distances(pos, cfg.centerPosition_m), R);
end
expected = cfg.numberOfCandidateNodes * pi * R^2 / (cfg.areaLength_m * cfg.areaWidth_m);
se = std(counts) / sqrt(trials);
ok = check(ok, sprintf('mean node count vs n*pi*R^2/L^2 (%.2f)', expected), ...
    abs(mean(counts) - expected) < 5*se);

if ok, fprintf('  All regression checks passed.\n\n');
else,  fprintf('  Regression checks FAILED.\n\n'); end
end

function ok = check(ok, name, pass)
if pass, tag = 'OK  '; else, tag = 'FAIL'; end
fprintf('  [%s] %s\n', tag, name);
ok = ok && pass;
end
