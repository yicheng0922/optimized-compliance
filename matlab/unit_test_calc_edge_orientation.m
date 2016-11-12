% an edge pointing in the direction pi/4 measured ccw from x axis
edge = [0 5; 0 5];
assert(calc_edge_orientation(edge) == pi/4);

% pointing at positive x
edge = [0 0; 0 5]
assert(calc_edge_orientation(edge) == pi/2)