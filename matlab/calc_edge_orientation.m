function edge_alpha = calc_edge_orientation( edge_x, edge_y )
% function that calculates the orientation measured counter clockwise 
% with respect to the x axis of the input edge
% function takes in edge as input where the first column is the starting vertex
% and the second column is the ending vertex
% returns the orientation

% TODO: use an cell structure for edge

y_diff = edge_y(2) - edge_y(1);
x_diff = edge_x(2) - edge_x(1);
edge_alpha = atan2(y_diff, x_diff);

end

