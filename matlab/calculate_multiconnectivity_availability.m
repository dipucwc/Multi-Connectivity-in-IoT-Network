function availability = calculate_multiconnectivity_availability(linkAvailability, connectivityOrder)
%%
%% Multi-Connectivity Availability:
%%
%{
Probability that at least one of K candidate serving links is available under statistically independent
link failures: A = 1 - (1 - p)^K. K = 1, 2, 3 gives single, dual, and triple connectivity; for p = 0.9
the closed-form values are 0.9, 0.99, and 0.999, which the regression checks reproduce.

Input:

    linkAvailability     Individual-link availability in [0, 1].
    connectivityOrder    Number of candidate serving links K.

Output:

    availability         Multi-connectivity availability, same size as linkAvailability.
%}

validateattributes(linkAvailability,  {'numeric'}, {'real', '>=', 0, '<=', 1});
validateattributes(connectivityOrder, {'numeric'}, {'scalar', 'integer', 'positive'});

availability = 1 - (1 - linkAvailability).^connectivityOrder;
end
