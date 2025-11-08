function Summary_Table(drones, fire, safePos)
% Summary Table -  The purpose of the summary table is generate a table of
% both fire and drone metric 
% INPUTS:
%   - fire - fire struct
%   - drones - drones struct
%OUTPUTS:
%   - Tables the drone data over the course of the simluation
%   - Tables the fire data over the course of the simluation


numberofdrones = numel(drones)
Summary = struct([])

    for i = 1:numberofdrones                        %number of drones we run this simulation
Summary(i).DroneID = i                             %"name" attached to each drone as their ID
Summary(i).Distance = drones(i).logs.distance       % total distance each drone traveled
Summary(i).Fires_Extinguished = cellsExtinguished    % total number of fires extinguished thorughout simulation
Summary(i).Collision_Avoidance_Counter = safePos(i)   % number of times each drone had a close encounter
Summary(i).Final_Postion = drones(i).pos            % final position of each drone
    end

Summary_Table = struct2table(Summary)
disp(Summary_Table);

end
