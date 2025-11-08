function [fireOut, cellsExtinguished] = deployWater(fire, target, radius)

fireOut = fire;                                    % gets the fire and turns into fireout, simulating dropping water
cellsExtinguished = 0;                             % amount of cells that get water deployed 

rows = size(fire.intensity,1);                     % All of the cells in the row and cols matrix "grid", get selected
cols = size(fire.intensity,2);

RowTarget = target(1);                                              
ColumnTarget = target(2);

for r = 1:rows                                                     % for loop of the row and column grid
    for c = 1:cols
        if hypot(r - RowTarget, c - ColumnTarget) <= radius        % drops the water a "radius" amount in the row and column grid
            if fireOut.intensity(r,c) > 0                          % if statement where counts a cell that had fire, simulating a cell that will be counted as extinguished 
                cellsExtinguished = cellsExtinguished + 1;         % adds to counter each time a cell gets extinguished
            end
            fireOut.intensity(r,c) = 0;                            % sets the fire intensity to 0, therefore making the cell "extinguished"
        end
    end
end
end
