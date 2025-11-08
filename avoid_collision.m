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

function newPos = move_toward(currPos, targetPos, speed, dt, gridSize)

direction  = targetPos - currPos; % Direction will be the position of target - current position
distance = norm(direction);       % Gets the amount gotten from direction and makes it the distance

    if distance == 0              % if drone distance to fire is 0, drone already at cell, keeps drone at cell
        newPos = currPos; 
        return;
    end

step = speed * dt;                % amount of distance drone will move slightly so it wont look like it instantly moves to cell, actually travels to cells

    if step >= distance           % if distance is less than step, drone at the cell so traveling is done and sets target position into new position
        newPos = targetPos;
    else
        directionUnit = direction / distance;        % otherwise drone will keep moving in target direction slighlty to give appearence of traveling
        newPos  = currPos + directionUnit * step;
    end


newPos(1) = min(max(newPos(1), 1), gridSize(1));       % Keeps drones in row and column grid
newPos(2) = min(max(newPos(2), 1), gridSize(2));

end
