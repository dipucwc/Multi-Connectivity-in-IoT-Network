function distances_m = calculate_distances(nodePositions_m, referencePosition_m)
%%
%% Euclidean Distances to a Reference Point:
%%
%{
Distance from every node position to one reference coordinate, used by the radius, coverage, and
node-qualification analyses.

Input:

    nodePositions_m       Node coordinates, N by 2.
    referencePosition_m   Reference coordinate, 1 by 2.

Output:

    distances_m           Distance vector in metres, N by 1.
%}

validateattributes(nodePositions_m,     {'numeric'}, {'2d', 'ncols', 2});
validateattributes(referencePosition_m, {'numeric'}, {'vector', 'numel', 2});

offsets = nodePositions_m - reshape(referencePosition_m, 1, 2);
distances_m = sqrt(sum(offsets.^2, 2));
end
