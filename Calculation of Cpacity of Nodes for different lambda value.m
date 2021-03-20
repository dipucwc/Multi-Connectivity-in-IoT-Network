clc
clear all
close all
%% Calculation of Cpacity of Nodes for different lambda value %%
% L = value of lamda
L=1000;
Lambda=zeros(1,10)
Xc=L/2
Yc=L/2
R=100
% fixed capacity
Cth = 1.5;

% Ns = Number of nodes for each radius
Ns=zeros(1,10);
for R=10:10:50
    index=1
for n = 100:100:1000;
    % Xp = position in the X axis
    Xp = rand(1,n).*L;
    % Yp = position in the Y axis
    Yp = rand(1,n).*L;
    % Calculation the value of lamda
    Lambda(index) = (n) /(L*L);
    % Calculation the value of distance
    for i = 1:n
        Ds(i) = sqrt((Xp(i)-Xc)^2 + (Yp(i)-Yc)^2);
      % calculation number of nodes for each radius
        if(Ds(i)<R)
            Ns(index)=Ns(index)+1;
            
        end
    end
    index=index+1
    
end
hold on;
%% Plotting Lambda Vs number of Nodes %%
plot(Lambda(1:1:10),Ns(1:1:10))
title('Lambda Vs Ns')
xlabel('Lambda')
ylabel('Ns')
end



