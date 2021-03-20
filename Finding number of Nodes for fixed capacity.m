clc
clear all
close all
%% Finding number of Nodes for fixed capacity %%
% fixed capacity
Cth = 1.5; 

% number of nodes
Nds = 5;

% random power p1, ... , p5
p = randi([1 10],1,Nds);

% Xo & Yo
Xo = 2;
Yo = 5;

% Xl & Yl
Xl = randi([-10 10],1,Nds);
Yl = randi([-10 10],1,Nds);

% rondom (Xr, Yr)
Xr = randi([-10 10],1,Nds);
Yr = randi([-10 10],1,Nds);

% rondom (Xdr, Ydr)
Xdr = randi([-10 10],1,Nds);
Ydr = randi([-10 10],1,Nds);

% calculate drr, dlr
for i = 1:Nds
    drr(i) = sqrt((Xr(i)-Xdr(i)).^2 + (Yr(i)-Ydr(i)).^2);
    dlr(i) = sqrt((Xl(i)-Xr(i)).^2 + (Yl(i)-Yr(i)).^2);
end

% calculate
% Ds = distance of every node from (Xo,Yo)
% capacity 
for i = 1:Nds
    Ds(i) = sqrt((Xl(i)-Xo).^2 + (Yl(i)-Yo).^2);
    % calculate capacity for node
    capacity(i) = capacityForNode(p, drr(i), dlr);
end

% Rs = radius of circle
max_Rs = ceil(max(Ds)) + 1;
Rs = [1:max_Rs];
len_Rs = length(Rs);

% Ns = Number of nodes for each radius 
Ns = zeros(1, len_Rs); % (initially 0)

for R = Rs
    for i = 1:length(Ds)
        if(Ds(i) <= R && capacity(i) > Cth)
            Ns(R) = Ns(R)+ 1; 
        end
    end
end
%% Plotting Radius Vs number of Nodes for fixed Capacity %%
figure
plot(Rs, Ns, '-o')
title('Rs Vs Ns')
xlabel('Rs')
ylabel('Ns')
xlim([0 len_Rs])
ylim([0 max(Ns)+1])