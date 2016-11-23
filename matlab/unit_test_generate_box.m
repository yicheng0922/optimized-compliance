% the information used to generate box starts here
spring_length = 4;
alpha = 0;
vertex1x = 10;
vertex1y = 0;
vertex2x = 15;
vertex2y = 0;

% generate the shape based on the data
shape = generate_box(spring_length, alpha, vertex1x, vertex1y, vertex2x, vertex2y );

% x and y should be the midpoint of the x and y coordinate
assert(shape.x == 12.5);
assert(shape.y == 0);
% the width should be the distance of the edge
assert(shape.w == 5);
% the height should be the spring length
assert(shape.h == 4);
% the alpha should be the alpha input
assert(alpha == 0);
