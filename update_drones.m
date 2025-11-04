function [drone, fire] = update_drone(drone, fire, params, drones, thisIdx)
% UPDATE_DRONE
% Performs one update step for a single drone:
%   - (Re)selects a target if needed
%   - Moves toward that target at constant speed
%   - Avoids collisions with other drones
%   - Drops water if within range (zeroes fire intensity)
%   - Logs position, events, and extinguished fire count
%
% INPUTS:
%   drone   - struct with current drone state
%   fire    - struct with current fire intensity map
%   params  - global simulation parameters
%   drones  - array of all drones (for collision avoidance)
%   thisIdx - index of the current drone
%
% OUTPUTS:
%   drone   - updated drone struct
%   fire    - updated fire struct (after possible water drop)
%
% Dependencies:
%   select_target.m
%   is_target_valid.m
%   move_toward.m
%   avoid_collision.m
%   drop_water_at_target.m
%   log_drone_state.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dt          = params.dt;
gridSize    = params.grid_size;
speed       = params.drone_speed;
dropRadius  = params.water_drop_radius;
stopThresh  = params.stop_condition;

% 1) Ensure the drone has a valid target (cell above threshold)
if isempty(drone.target) || ~is_target_valid(drone.target, fire, stopThresh)
    drone.target = select_target(fire, params);  % pick hottest cell
end

% 2) If no valid target found (all fires below threshold), just idle
if isempty(drone.target)
    drone = log_drone_state(drone, drone.pos, params.t, 'idle-no-target');
    return
end

currPos = drone.pos;

% 3) Move toward target
proposedPos = move_toward(currPos, drone.target, speed, dt, gridSize);

% 4) Collision avoidance: stay put if near another drone
proposedPos = avoid_collision(proposedPos, currPos, drones, thisIdx);

% 5) Log distance traveled
distStep = norm(proposedPos - currPos);
drone.logs.distance = drone.logs.distance + distStep;

% 6) Commit position update
drone.pos = proposedPos;

% 7) Check if within water-drop range of target
if norm(drone.pos - drone.target) <= dropRadius
    % Drop water and modify fire directly
    [fire, cellsExtinguished] = drop_water_at_target(fire, drone.target, dropRadius);
    drone.logs.extinguished_count = drone.logs.extinguished_count + cellsExtinguished;
    
    % Log the event
    drone = log_drone_state(drone, drone.pos, params.t, 'water-drop');
    
    % Resupply: clear target so a new one will be selected next step
    drone.target = [];
else
    % Normal movement log
    drone = log_drone_state(drone, drone.pos, params.t, 'move');
end

end
