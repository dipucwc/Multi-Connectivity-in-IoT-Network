function Crr = capacityForNode(p, dn, dln)

    % constant values
    ALPHA = 2;
    W = 100;
    No = 1;
    Po = 1;

    len = length(p);
    % calculate capacity
    sum = 0;
    for i = 1:len
        pdn = p(i)*dln(i).^-ALPHA;
        sum = sum + pdn;
    end
    Crr = W*log(1+(Po*dn.^-ALPHA)/(No+sum));
    
end