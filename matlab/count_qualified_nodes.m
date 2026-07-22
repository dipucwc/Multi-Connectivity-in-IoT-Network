function qualifiedNodeCount = count_qualified_nodes(distances_m, nodeCapacity, ...
    radiusVector_m, capacityThreshold)
%%
%% Jointly Qualified Node Count:
%%
%{
Counts nodes that satisfy the coverage-radius and minimum-capacity conditions simultaneously, per radius
value. Used to study how many candidate serving nodes remain under joint geometric and link-quality
constraints.

Input:

    distances_m, nodeCapacity, radiusVector_m, capacityThreshold

Output:

    qualifiedNodeCount    Qualified node count for each radius.
%}

if numel(distances_m) ~= numel(nodeCapacity)
    error('Distance and capacity vectors must have equal lengths.');
end
validateattributes(radiusVector_m,    {'numeric'}, {'vector', 'nonnegative'});
validateattributes(capacityThreshold, {'numeric'}, {'scalar', 'nonnegative'});

distances_m    = distances_m(:);
nodeCapacity   = nodeCapacity(:);
radiusVector_m = radiusVector_m(:).';

qualified = (nodeCapacity >= capacityThreshold);
qualifiedNodeCount = sum((distances_m <= radiusVector_m) & qualified, 1);
end
