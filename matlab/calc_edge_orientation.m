function edge_alpha = calc_edge_orientation( edge_x, edge_y )
% function that calculates the orientation measured counter clockwise 
% with respect to the x axis of the input edge
% inputs:
%   edge_x: a vector containing the x coordinates of the two vertex
%   edge_y: a vector containing the y coordinates of the two vertex
% output:
%   edge_alpha: the orientation of this edge measured ccw with respect to
%   the positive x axis.

y_diff = edge_y(2) - edge_y(1);
x_diff = edge_x(2) - edge_x(1);
edge_alpha = atan2(y_diff, x_diff);

end

