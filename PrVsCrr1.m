clc
clear all
close all
%% Calculation Power of Nodes %%
ALPHA1 = 2;
ALPHA2 = 4;
W = 100;
No = 1;
Pl = 5;

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
Crr1 = zeros(1, Pr_length); % for ALPHA1 [ALPHA = 2]
Cll1 = zeros(1, Pr_length); % for ALPHA1 [ALPHA = 2]
Crr2 = zeros(1, Pr_length); % for ALPHA2 [ALPHA = 4]
Cll2 = zeros(1, Pr_length); % for ALPHA2 [ALPHA = 4]

% calculate capacity
for p = Pr
    % for ALPHA1 [ALPHA = 2]
    Cll1(p) = W*log(1+(Pl*dll.^-ALPHA1)/(No+p*drl.^-ALPHA1));
    Crr1(p) = W*log(1+(p*drr.^-ALPHA1)/(No+Pl*dlr.^-ALPHA1));
    % for ALPHA2 [ALPHA = 4]
    Cll2(p) = W*log(1+(Pl*dll.^-ALPHA2)/(No+p*drl.^-ALPHA2));
    Crr2(p) = W*log(1+(p*drr.^-ALPHA2)/(No+Pl*dlr.^-ALPHA2));
end
%% Plotting Power Vs capacity curve %%

% for ALPHA1 [ALPHA = 2]
figure('Name','Pr-Vs-Crr','NumberTitle','off');
plot(Pr, Crr1, '-o', Pr, Crr2, '-x');
legend('ALPHA = 2','ALPHA = 4');
title('Pr Vs Crr');
xlabel('Pr');
ylabel('Crr');
% xlim([0 Pr_length+1])
% ylim([0 max(Crr1)+1])