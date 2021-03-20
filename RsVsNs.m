clc
clear all
close all
%% Finding distance of the Nodes and number of Nodes in each Radius %%

% Xp = position in the X axis
Xp = randi([-10 10],1,10);

% Yp = position in the Y axis
Yp = randi([-10 10],1,10);

% Xc = position of the center node in the X axis
Xc = 2;

% Yc = position of the center node in the Y axis
Yc = 5;

% Ds = distance from center node
%%{
for i = 1:length(Xp)
    Ds(i) = sqrt((Xp(i)-Xc).^2 + (Yp(i)-Yc).^2);
end
%%}

% Rs = radius of circle
max_Rs = ceil(max(Ds)) + 1;
Rs = [1:max_Rs];
len_Rs = length(Rs);

% Ns = Number of nodes for each radius 
Ns = zeros(1, len_Rs); % (initially 0)

for R = Rs
    for d = Ds
        if(d <= R)
            Ns(R) = Ns(R)+ 1; 
        end
    end
end
%% Plotting Radius Vs Number of nodes %%
figure
plot(Rs, Ns, '-o')
title('Radius Vs Number of nodes')
xlabel('Rs')
ylabel('Ns')
xlim([0 len_Rs])
ylim([0 max(Ns)+1])