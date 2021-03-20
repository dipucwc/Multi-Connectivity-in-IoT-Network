clc
clear all
close all
%% Calculation Power of Nodes %%
ALPHA = 2;
W = 100;
No = 1;
Pl1 = 1;
Pl5 = 5;
Pl10 = 10;

% rondom (Xl, Yl)
Xl = randi([-10 10],1,1);
Yl = randi([-10 10],1,1);

% rondom (XdL, YdL)
Xdl = randi([-10 10],1,1);
Ydl = randi([-10 10],1,1);

% rondom (Xr, Yr)
Xr = randi([-10 10],1,1);
Yr = randi([-10 10],1,1);

% rondom (Xdr, Ydr)
Xdr = randi([-10 10],1,1);
Ydr = randi([-10 10],1,1);

% calculate dll, drr, dlr, drl
dll = sqrt((Xl-Xdl).^2 + (Yl-Ydl).^2);
drr = sqrt((Xr-Xdr).^2 + (Yr-Ydr).^2);
dlr = sqrt((Xl-Xr).^2 + (Yl-Yr).^2);
drl = sqrt((Xr-Xl).^2 + (Yr-Yl).^2);

% increase power from 1 to lr
Pr = 1:10;

% initialize Crr & Cll
Pr_length = length(Pr);
Crr1 = zeros(1, Pr_length); % for Pl1 [Pl1 = 1]
Cll1 = zeros(1, Pr_length); % for Pl1 [Pl1 = 1]
Crr2 = zeros(1, Pr_length); % for Pl5 [Pl5 = 5]
Cll2 = zeros(1, Pr_length); % for Pl5 [Pl5 = 5]
Crr3 = zeros(1, Pr_length); % for Pl10 [Pl10 = 10]
Cll3 = zeros(1, Pr_length); % for Pl10 [Pl10 = 10]

% calculate capacity
for p = Pr
    % for Pl1 [Pl1 = 1]
    Cll1(p) = W*log(1+(Pl1*dll.^-ALPHA)/(No+p*drl.^-ALPHA));
    Crr1(p) = W*log(1+(p*drr.^-ALPHA)/(No+Pl1*dlr.^-ALPHA));
    % for Pl5 [Pl5 = 5]
    Cll2(p) = W*log(1+(Pl5*dll.^-ALPHA)/(No+p*drl.^-ALPHA));
    Crr2(p) = W*log(1+(p*drr.^-ALPHA)/(No+Pl5*dlr.^-ALPHA));
    % for Pl10 [Pl10 = 10]
    Cll3(p) = W*log(1+(Pl10*dll.^-ALPHA)/(No+p*drl.^-ALPHA));
    Crr3(p) = W*log(1+(p*drr.^-ALPHA)/(No+Pl10*dlr.^-ALPHA));    
end
%% Plotting Power (different value of power) Vs capacity curve %%
% for Pl = 1, 5, 10
figure('Name','Pr-Vs-Crr','NumberTitle','off');
plot(Pr, Crr1, '-c', Pr, Crr2, '-x', Pr, Crr2, '-m');
legend('Pl = 1','Pl = 5', 'Pl = 10');
title('Pr Vs Crr');
xlabel('Pr');
ylabel('Crr');
% xlim([0 Pr_length+1])
% ylim([0 max(Crr1)+1])