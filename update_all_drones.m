function [drones, fire] = update_all_drones(drones, fire, params) % gets the update drone section and applies to all drones

numberofdrones = numel(drones);
    
    for (i = 1:numberofdrones) % for loop to make previous drones see updated position and infomration of next drone
        
        [drones(i), fire] = update_drone(drones(i), fire, params, drones, i);
        drones(i).pos = drones(i).pos;

    end
end
