clc
clear all
close all
%% Calculation of Cpacity of Nodes for fixed capacity %%
Cth = 1.5;

% number of nodes
Nds = 10;

% Xp = position in the X axis
Xp = randi([-10 10],1,Nds);

% Yp = position in the Y axis
Yp = randi([-10 10],1,Nds);

% Xc = position of the center node in the X axis
Xc = 2;

% Yc = position of the center node in the Y axis
Yc = 5;

% from center node
% Ds = distance 
% capacity
for i = 1:Nds
    Ds(i) = sqrt((Xp(i)-Xc).^2 + (Yp(i)-Yc).^2);
    capacity(i) = calculateCapacity(Xp(i),Yp(i));
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