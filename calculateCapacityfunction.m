%function [Cll, Crr] = calculateCapacity(Xl, Yl)
function Crr = calculateCapacity(Xl, Yl)

    % constant values
    ALPHA = 2;
    W = 100;
    No = 1;
    Pl = 5;
    Pr = 1;

    % rondom (Xl, Yl)
    %Xl = randi([-10 10],1,1);
    %Yl = randi([-10 10],1,1);

    % rondom (XdL, YdL)
    %Xdl = randi([-10 10],1,1);
    %Ydl = randi([-10 10],1,1);

    % rondom (Xr, Yr)
    Xr = randi([-10 10],1,1);
    Yr = randi([-10 10],1,1);

    % rondom (Xdr, Ydr)
    Xdr = randi([-10 10],1,1);
    Ydr = randi([-10 10],1,1);

    % calculate dll, drr, dlr, drl
    %dll = sqrt((Xl-Xdl).^2 + (Yl-Ydl).^2);
    drr = sqrt((Xr-Xdr).^2 + (Yr-Ydr).^2);
    dlr = sqrt((Xl-Xr).^2 + (Yl-Yr).^2);
    %drl = sqrt((Xr-Xl).^2 + (Yr-Yl).^2);

    % calculate capacity
    %Cll = W*log(1+(Pl*dll.^-ALPHA)/(No+Pr*drl.^-ALPHA));
    Crr = W*log(1+(Pr*drr.^-ALPHA)/(No+Pl*dlr.^-ALPHA));
end