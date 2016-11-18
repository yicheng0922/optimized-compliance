function shape = generate_box(spring_length, alpha, vertex1x, vertex1y, vertex2x, vertex2y )
% this function takes the configuration in and generate the box shape data.
% where spring_length is the length of the spring, alpha is the orientation
% of the box. vertex1x and vertex1y are the coordinates of the first vertex
% of the bottom edge. vertex2x and vertex2y are the coordinates of the
% bottom 
    shape.h = spring_length;
    shape.w = norm([vertex2x - vertex1x, vertex2y - vertex1y])
    shape.alpha = alpha;
    
    % the shape center is computed by finding the midpoint of the sector and translating it by half of the height in alpha direction. 
    shape.x = (vertex2x + vertex1x)/2;
    shape.y = (vertex2y + vertex1y)/2;
    shape.isRect = true;

end

