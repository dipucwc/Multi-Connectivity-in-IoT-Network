clc
clear all
close all
%% Calculation of Cpacity of Nodes for different value of capacity %%
% fixed capacity
Cth1 = 1;
Cth2 = 1.5;
Cth3 = 2;
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
Ns1 = zeros(1, len_Rs); % (initially 0)
Ns2 = zeros(1, len_Rs); % (initially 0)
Ns3 = zeros(1, len_Rs); % (initially 0)

for R = Rs
    for i = 1:length(Ds)
        if(Ds(i) <= R)
            if(capacity(i) > Cth1)
                Ns1(R) = Ns1(R)+ 1;
            end
            if(capacity(i) > Cth2)
                Ns2(R) = Ns2(R)+ 1;
            end
            if(capacity(i) > Cth3)
                Ns3(R) = Ns3(R)+ 1;
            end
        end
    end
end
%% Plotting Radius Vs number of Nodes for differnet value of Capacity %%
figure
plot(Rs, Ns1, '-o')
hold on
plot(Rs, Ns2, '-x')
hold on
plot(Rs, Ns3, '-*') 
hold off
legend('Cth = 1','Cth = 1.5', 'Cth = 2');
title('Rs Vs Ns')
xlabel('Rs')
ylabel('Ns')
%xlim([0 len_Rs])
%ylim([0 max(Ns1)+1])