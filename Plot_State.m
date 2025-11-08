function Plot_State(fire, params, drones, t)
% Plot_State is in charge of turing the data thorught the simulation into a
% heat map of the fire and the drones positions as a function of time
% INPUTS:
%   - params - params struct
%   - fire - fire struct
%   - drones - drones struct
%   - Summary_table
%OUTPUTS:
%   - Saves all the data throught the simulation for both visual
%   representation as well as reproducibility

% using imagesc we create a visual heatmap of the fire thorught the
% simulation
figure(1); clf;
imagesc(fire.intensity);
colormap hot; 
colorbar;
hold on;
grid on;
xlabel('Horizontal Position');
ylabel('Vertical Position');
title(sprintf('LIVE Heat Map of Fire... Time = %.2f s', t));

% not only are we gathering data regarding the fire we are also logging the
% drones position thorught this simulation

    for i = 1:length(drones)
        currPos = drones(i).pos;
        % position of drones on plot
        plot(currPos(1), currPos(2), 'o');
        % making sure to label each drone on plot
        text(currPos(1), currPos(2)+ 0.5, drones(i).DroneID, ...
            'HorizontalAlignment', 'center', 'color', 'blue');

    end

hold off;
drawnow;
end