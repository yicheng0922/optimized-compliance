function edge_alpha = calc_edge_orientation( edge )
% function that calculates the orientation of the of the input edge
% function takes in edge as input where edge(:,1) is the starting vertex
% and (:,2) is the ending vertex
% returns a 
y_diff = edge(2,2) - edge(2,1);
x_diff = edge(1,2) - edge(1,1);
edge_alpha = atan2(y_diff, x_diff);

end

