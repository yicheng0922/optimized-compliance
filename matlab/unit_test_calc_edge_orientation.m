
% pointing at positive x
edge_x = [0,5];
edge_y = [0,0];
assert(calc_edge_orientation(edge_x,edge_y) == 0)

% pointing at negative x
edge_x = [0,-5];
edge_y = [0,0];
assert(calc_edge_orientation(edge_x,edge_y) == pi)

% pointing at positive x
edge_x = [0,-5];
edge_y = [0,0];
assert(calc_edge_orientation(edge_x,edge_y) == pi/2)

% pointing at negative y
edge_x = [0,0];
edge_y = [0,-5];
assert(calc_edge_orientation(edge_x,edge_y) == 3*pi/2)

% an edge pointing in the direction pi/4 measured ccw from x axis
edge_x = [0,5];
edge_y = [0,5];
assert(calc_edge_orientation(edge_x,edge_y) == pi/4);

% an edge pointing in the direction 3*pi/4 measured ccw from x axis
edge_x = [0,-5];
edge_y = [0,5];
assert(calc_edge_orientation(edge_x,edge_y) == 3*pi/4)

% an edge pointing in the direction 5*pi/4 measured ccw from x axis
edge_x = [0,-5];
edge_y = [0,-5];
assert(calc_edge_orientation(edge_x,edge_y) == 5*pi/4)

% an edge pointing in the direction 7*pi/4 measured ccw from x axis
edge_x = [0,5];
edge_y = [0,-5];
assert(calc_edge_orientation(edge_x,edge_y) == 7*pi/4)
