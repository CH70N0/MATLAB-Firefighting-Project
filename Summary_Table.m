function Summary_Table = Summarize_Results(drones, fire)
    nD = numel(drones);
    DroneID = (1:nD).';
    DistanceTraveled  = zeros(nD,1);
    CellsExtinguished = zeros(nD,1);

    for i = 1:nD
        DistanceTraveled(i)  = drones(i).logs.distance;
        CellsExtinguished(i) = drones(i).logs.extinguished_count;
    end

    Summary_Table = table(DroneID, DistanceTraveled, CellsExtinguished);
    disp(Summary_Table);
end
