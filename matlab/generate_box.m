function shape = generate_box(spring_length, alpha, vertex1x, vertex1y, vertex2x, vertex2y )
% this function takes the configuration in and generate the box shape data.
% where spring_length is the length of the spring, alpha is the orientation
% of the box. vertex1x and vertex1y are the coordinates of the first vertex
% of the bottom edge. vertex2x and vertex2y are the coordinates of the
% second vertex of the bottom edge (see bottom_edge.png for a graphical
% explanation)

    shape.h = spring_length;
    shape.w = norm([vertex2x - vertex1x, vertex2y - vertex1y]);
    shape.alpha = alpha;
    
    % shape.x and shape.y represents the center of the bottom edge
    shape.x = (vertex2x + vertex1x)/2;
    shape.y = (vertex2y + vertex1y)/2;
    shape.isRect = true;

end

