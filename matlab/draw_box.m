function draw_box( shape, S )
% this function draws a box based on the shape data input
% S is the same character string used for plot(). Please see help plot for
% detail explanation

% make sure the shape data is a box    
assert(shape.isRect);

% compute the box vertex
vertex = compute_box_vertices( shape );

vertex = [vertex vertex(:,1)];

% plot the box
plot(vertex(1,:),vertex(2,:), S);


end

