function nodeCount = count_nodes_within_radius(distances_m, radiusVector_m)
%%
%% Node Count per Coverage Radius:
%%
%{
Counts how many candidate nodes lie inside every value of the radius vector. For a uniform deployment of
n nodes over an L x L area, the expected count inside radius R is n pi R^2 / L^2, which the regression
checks use as a closed-form reference.

Input:

    distances_m, radiusVector_m

Output:

    nodeCount    Number of nodes inside each radius, same length as radiusVector_m.
%}

validateattributes(distances_m,    {'numeric'}, {'vector', 'nonnegative'});
validateattributes(radiusVector_m, {'numeric'}, {'vector', 'nonnegative'});

distances_m    = distances_m(:);
radiusVector_m = radiusVector_m(:).';
nodeCount = sum(distances_m <= radiusVector_m, 1);   % vectorized N x R comparison
end
