function [drone, fire] = update_drone(drone, fire, params, drones, thisIdx)
% only updates 1 drone not all yet
dt          = params.dt;                                              % Time
gridSize    = params.grid_size;                                       % Size of the grid
speed       = params.drone_speed;                                     % Radius of the drop of water
dropRadius  = params.water_drop_radius;                               % Threshold to stop
stopThresh  = params.stop_condition;

    if isempty(drone.target) || ~is_target_valid(drone.target, fire, stopThresh)  % Checks for valid target, if cell is on fire and empty

        drone.target = select_drone_target(fire, params);

    end

    if isempty(drone.target)                                               % If no target, only logs cell

        drone = log_drone_state(drone, drone.pos, params.t, 'idle-no-target');
        return

    end

currPos = drone.pos;                                                   % Gets the drone position and names it currPos for current Position

proposedPos = move_toward(currPos, drone.target, speed, dt, gridSize); % Moves to new target

proposedPos = avoid_collision(proposedPos, currPos, drones, thisIdx);  % Collision avoidance

distStep = norm(proposedPos - currPos);                                % Distance from proposed position - current positon

drone.logs.distance = drone.logs.distance + distStep;

drone.pos = proposedPos;                                                               % Commits to positon

    if norm(drone.pos - drone.target) <= dropRadius                                    % Drops the water 
    
    [fire, cellsExtinguished] = deployWater(fire, drone.target, dropRadius);  % Makes water cover fire cell now, extinguish

    drone.logs.extinguished_count = drone.logs.extinguished_count + cellsExtinguished;

    drone = log_drone_state(drone, drone.pos, params.t, 'water-drop');

    drone.target = [];                                                                % resupply: force new target next step

    else
            drone = log_drone_state(drone, drone.pos, params.t, 'move');
    end

end
