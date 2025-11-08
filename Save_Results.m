function Save_Results(fire, drones, params, Summary_Table)
% Save_Results -  The purpose of the Save_Results is to save the data
% regarding the simualtion to (.mat, .csv) for reproducibility
% INPUTS:
%   - fire - fire struct
%   - drones - drones struct
%   - Summary_Table
%   - params - params struct
%OUTPUTS:
%   - Saves data to both a .mat and .csv for reproducibility
% timestamp serves to create a unique footprint for each and every
% Simulation DATA
timestamp = datestr(now, 'yyyymmdd_HHMMSS');       

% To ensure that each simulations data is different and not overwritten 
% previously  had it so that it would get rewrtitten each time but with the
% help of AI it help me change it.

Drone_Fire_Results = ['Drone_Fire_Simulation_Results', timestamp, '.csv'];
SimData = ['FireFighting_FinalDATA', timestamp, '.mat'];


writetable(Summary_Table, Drone_Fire_Results);
save(SimData, "drones", "fire", "params", "timestamp");
end

