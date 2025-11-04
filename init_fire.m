function fire = init_fire(params)
% INIT_FIRE  Initializes the fire struct for the simulation.
%
% DESCRIPTION:
%   Creates a 2D matrix representing the fire intensity across the grid.
%   A few random "hotspot" cells are initialized with maximum intensity.
%   All other cells start at intensity = 0. Also initializes simulation time t = 0.
%
% INPUT:
%   params (struct) - contains at least the following fields:
%       • gridSize         – [rows, cols] of the fire grid
%       • initialHotspots  – number of random hotspots to place
%       • initialPeak      – intensity value assigned to each hotspot (usually 1.0)
%
% OUTPUT:
%   fire (struct) with fields:
%       • intensity – R×C matrix of fire intensity (values in [0,1])
%       • t         – current simulation time (starts at 0)
%


% Grid dimensions
row = params.grid_size(1);
col = params.grid_size(2);

% Initialize an empty fire map
intensity = zeros(row, col);

% Add random hotspots
for k = 1:params.initialHotspots
    row0 = randi([3, row-2], 1);  % avoid edges
    col0 = randi([3, col-2], 1);
    intensity(row0, col0) = 1;
end

% Store in struct
fire.intensity = intensity;
fire.t = 0;
end