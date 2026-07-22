function capacity = calculate_link_capacity(desiredPower, desiredDistance_m, ...
    interferencePower, interferenceDistance_m, bandwidth_Hz, noisePower, ...
    pathLossExponent, minimumDistance_m)
%%
%% Interference-Limited Link Capacity:
%%
%{
Shannon-style capacity of one link under path loss, integrated noise, and aggregate interference:
SINR = P_s d_s^-alpha / (N0 + sum P_i d_i^-alpha), C = W log2(1 + SINR). The original scripts used the
natural logarithm; log2 is used here so the result reads in bit/s when W is in hertz (the change is a
constant factor 1/ln 2 and does not alter any monotonic behavior). All quantities are in the normalized
units of default_parameters. Distances below minimumDistance_m are clamped for numerical stability.

Input:

    desiredPower, desiredDistance_m, interferencePower, interferenceDistance_m,
    bandwidth_Hz, noisePower, pathLossExponent, minimumDistance_m

Output:

    capacity     Link capacity (bit/s for W in Hz; normalized units here).
%}

validateattributes(desiredPower,      {'numeric'}, {'scalar', 'nonnegative'});
validateattributes(desiredDistance_m, {'numeric'}, {'scalar', 'nonnegative'});
validateattributes(bandwidth_Hz,      {'numeric'}, {'scalar', 'positive'});
validateattributes(noisePower,        {'numeric'}, {'scalar', 'nonnegative'});
validateattributes(pathLossExponent,  {'numeric'}, {'scalar', 'positive'});
validateattributes(minimumDistance_m, {'numeric'}, {'scalar', 'positive'});
if numel(interferencePower) ~= numel(interferenceDistance_m)
    error('Interference power and distance inputs must have equal lengths.');
end

desiredDistance_m      = max(desiredDistance_m, minimumDistance_m);
interferenceDistance_m = max(interferenceDistance_m, minimumDistance_m);

desiredReceivedPower  = desiredPower .* desiredDistance_m.^(-pathLossExponent);
aggregateInterference = sum(interferencePower(:) .* interferenceDistance_m(:).^(-pathLossExponent));

sinrLinear = desiredReceivedPower ./ (noisePower + aggregateInterference);
capacity   = bandwidth_Hz .* log2(1 + sinrLinear);
end
