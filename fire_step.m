function fire = fire_step(fire, params)
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
%       • fire.intensity – current fire intensity grid
%       • fire.t         – (time value is NOT advanced here)
%
%   params (struct) with fields:
%       • spreadK         – amount of fire spread to orthogonal neighbors per step
%       • decayK          – global decay per step (subtracted after spreading)
%       • diagSpreadProb  – (optional) 0 to 1, scales diagonal spread
%
% OUTPUT:
%   fire (struct) – updated intensity matrix; time 'fire.t' unchanged here
%
% EQUATION (simplified):
%   I(r,c)_{new} = clamp01( I(r,c) + k * (N + S + E + W) - decayK )
%


I = fire.intensity; % current intensity map
k = params.spreadK; % orthogonal spread coefficient

% --- 1. Orthogonal spread (N,S,E,W) via convolution kernel ---
K = [0 k 0;
     k 0 k;
     0 k 0];
incomingOrth = conv2(I, K, 'same');
newI = I + incomingOrth;  % add fire from neighbors

% --- 2. Optional diagonal spread (extra credit) ---
p = 0;
if isfield(params, 'diagSpreadProb')
    p = max(0, min(1, params.diagSpreadProb));  % keep in [0, 1]
end
if p > 0
    kd = 0.5 * k;   % diagonal usually weaker than orthogonal
    KD = [kd 0 kd;
          0  0  0;
          kd 0 kd];
    incomingDiag = conv2(I, KD, 'same');
    newI = newI + p * incomingDiag;
end

% --- 3. Global decay ---
newI = newI - params.decayK;

% --- 4. Clamp to [0, 1] ---
newI(newI < 0) = 0;
newI(newI > 1) = 1;

% Save updated intensity back to struct
fire.intensity = newI;

end
