%
% Copyright (c) 2019, Ritwik Raha
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: Particle-Swarm-Optimization-using-Matlab
% 
%

clc;
clear;
close all;

%% Problem Definiton
I=imread('a9.tif');

problem.CostFunction = @(x) CostCriteria(I);  % Cost Function
problem.nVar = 3;       % Number of Unknown (Decision) Variables
problem.VarMin =  -10;  % Lower Bound of Decision Variables
problem.VarMax =  10;   % Upper Bound of Decision Variables

%% Parameters of PSO

params.MaxIt = 100;        % Maximum Number of Iterations
params.nPop = 20;           % Population Size (Swarm Size)
params.u = rand;               % Intertia Coefficient
params.beta = 0.25;             % Contraction expansion coefficient
params.chi = rand;             % a random value between 0 and 1
params.ShowIterInfo = true; % Flag for Showing Iteration Informatin

%% Calling PSO

out = QPSO(problem, params);

BestSol = out.BestSol
BestCosts = out.BestCosts;

%% Results

figure;
plot(BestCosts, 'LineWidth', 4);
%semilogy(BestCosts, 'LineWidth', 4);
xlabel('Iteration');
ylabel('Best Solutions');
grid on;


