function = fire_step(fire, params)
% FIRE_STEP  Updates fire intensity grid for one simulation time-step.
%
% DESCRIPTION:
%   Implements the cellular-automaton fire model:
%       1. Fire spreads to the four orthogonal neighbors (N, S, E, W)
%          based on params.spreadK.
%       2. Global decay reduces fire intensity everywhere.
%       3. Intensities are clamped to [0,1] to maintain valid bounds.
%
% INPUT:
%   fire (struct)
%     - fire.intensity – current fire intensity grid
%     - fire.spread - spread coefficient for the fire
%
%   params (struct):
%     - params.spreadK – amount of fire spread to orthogonal neighbors per step
%     - params.decay – global decay per step
%     - params.t - current time
%         
%
% OUTPUT:
%   fire (struct) – updated intensity matrix
%
% EQUATION (simplified):
%   I(r,c)_{new} = clamp01( I(r,c) + k * (N + S + E + W) - decayK )
%

I = fire.intensity; % current intensity map
k = params.spreadK; % orthogonal spread coefficient

% Orthogonal spread (N,S,E,W)
K = [0 k 0;
     k 0 k;
     0 k 0];
incomingOrth = conv2(I, K, 'same');
newI = I + incomingOrth;  % add fire from neighbors

% Global decay
newI = newI - params.decayK;

% Clamp to [0, 1]
newI(newI < 0) = 0;
newI(newI > 1) = 1;

% Save updated intensity back to struct
fire.intensity = newI;
end

