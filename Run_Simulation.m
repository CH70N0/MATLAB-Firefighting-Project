function Run_Simulation(fire, params, drones)
% Run_Simulation is in charge of running the entire simluation regarding
% drones fighting the spreading wildfire within the given time constraints
% INPUTS:
%   - params - params struct
%   - fire - fire struct
%   - drones - drones struct
%OUTPUTS:
%   - Summary_Table - gathers all the data regarding the run of the drone
%   status , fire status.
t = 0;
    disp("START OF FIRE");
    while t <= params.t_max
        if all(fire.intensity(:) < params.stop_condition)   % simultion stops when conidition are cleared
            disp("FIRE EXTINGUSHIED")
            break
        end
% updates the fire throughout the simulation 
fire = fire_step(fire, params);
%updates the drones thorught the simulation
    for i = 1:length(drones)
        [drones(i), fire] = update_drone(drones(i), fire, params, drones, i);
    end
%creates the data regarding the visualtion of the simulation
    if mod(round(t / params.dt), 10) == 0            % AI  helped when it came to plotting every 10 steps rather every single interation
        Plot_State(fire, params, drones, t);
        drawnow;
    end
    t = t +params.dt;
    params.t = t;
    end
    disp("Simulation complete please wait...");
Summary_Table = Summarize_Results(drones, fire);  % gathers the data of both the fires and the drones thourght the simlaution
Save_Results(drones, fire, params, Summary_Table); % saves data of each simulation
end
