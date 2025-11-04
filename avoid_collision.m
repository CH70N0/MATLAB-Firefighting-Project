function safePos = avoid_collision(proposedPos, currPos, drones, thisIdx) % Safe position means no drone to colldie

safePos = proposedPos;              % Gets the target position at first before checking just to get the cell
numberofDrones = numel(drones);     
minSep = 0.5;                       % Minimum safe distance in grid units, here only 0.5 can increase to make gap wider

    for j = 1:numberofDrones
        if j == thisIdx             % This will make drone not count itself as another drone that would be too close
            continue; 
        end

        otherPos = drones(j).pos;   % Gets the information on the position of other drones

        if norm(safePos - otherPos) < minSep  % If the targeted positon is too close and might collide, does the following, stays in current positition and makes it safe positon

            safePos = currPos;

            return

        end
    end
end
