function shape = generate_box( displacement, spring_length, alpha, vertex1x, vertex1y, vertex2x, vertex2y )
% this function takes the configuration in and generate the box shape data.

    shape.h = spring_length + displacement;
    shape.w = norm([vertex2x - vertex1x, vertex2y - vertex1y])
    shape.alpha = alpha;
    
    % the shape center is computed by finding the midpoint of the sector and translating it by half of the height in alpha direction. 
    shape.x = (vertex2x + vertex1x)/2 + cos(shape.alpha) * shape.h/2 ;
    shape.y = (vertex2y + vertex1y)/2 + sin(shape.alpha) * shape.h/2;
    shape.isRect = true;

end

