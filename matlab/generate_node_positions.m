function positions = generate_node_positions(numberOfNodes, areaLength_m, areaWidth_m)
%%
%% Uniform Node Deployment:
%%
%{
Generates two-dimensional node locations uniformly distributed over the rectangular service area. All
coverage, density, capacity, and reliability studies reuse this one deployment utility; the caller sets
the seed, so a deployment is reproducible per run script.

Input:

    numberOfNodes, areaLength_m, areaWidth_m

Output:

    positions    Node coordinates, numberOfNodes by 2, in metres.
%}

validateattributes(numberOfNodes, {'numeric'}, {'scalar', 'integer', 'positive'});
validateattributes(areaLength_m,  {'numeric'}, {'scalar', 'positive'});
validateattributes(areaWidth_m,   {'numeric'}, {'scalar', 'positive'});

positions = [rand(numberOfNodes, 1) .* areaLength_m, ...
             rand(numberOfNodes, 1) .* areaWidth_m];
end
