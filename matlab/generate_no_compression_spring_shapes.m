function box_springs = generate_no_compression_spring_shapes( box_vertices_x, box_vertices_y , edge_spring_numbers, vertex_spring_numbers, spring_length)
%   This generates the shape information for the springs when there is no
%   compression.
%   The function takes the following inputs:
%       box_vertices_x: A 1*4 array where every element is the x coordinate of
%                      a vertex from the box. The vertices should be in ccw order
%       box_vertices_y: A 1*4 array where every element is the y coordinate of
%                      a vertex from the box. The vertices should be in ccw order
%       edge_spring_numbers: A 1*4 array that holds how many springs should
%                           be on every edge
%       vertex_spring_numbers: A 1*4 array that holds how many springs
%                              should be on every vertex
%       spring_length: the length of the springs

vertex_num = size(box_vertices_x,1);
box_springs = [];
edge_alphas = [];

% create edge springs
for i = 1:vertex_num
    
    cur_edge_x = box_vertices_x(i, mod(i+1,vertex_num));
    cur_edge_y = box_vertices_y(i, mod(i+1,vertex_num));
    
    % calculate orientation of the edge with respect to x axis
    edge_alpha = calc_edge_orientation(cur_edge_x, cur_edge_y);
    edge_alphas = [edge_alphas, edge_alpha];

    % split the edge into intervals, every interval represents a spring
    % because interval number = point number - 1 , so we need to add one to
    % the spring number when splitting the edge
    splitted_x = linspace(cur_edge_x(1),cur_edge_x(2),edge_spring_numbers(i)+1);
    splitted_y = linspace(cur_edge_y(1),cur_edge_y(2),edge_spring_numbers(i)+1);
    
    % create shapes for edge springs
    for (ii = 1:edge_spring_numbers(i))
        shape = generate_box(spring_length,edge_alpha, splitted_x(ii),splitted_x(ii+1),splitted_y(ii),splitted_y(ii+1));
        box_springs= [boxsprings;{shape}];
    end
end

clear shape;

for i=1:vertex_num
    
    % find the starting and the ending angle of the voronoi region of the
    % i-th vertex
    voronoi_start_angle = mod(edge_alpha(i)+pi/2,2*pi);
    voronoi_end_angle = mod(edge_alpha(mod(i-1,vertex_num))+pi/2,2*pi);
    
    % split the angle into intervals, each interval represents a vertex
    % spring.
    % same as the edge splitting, we need to add one to the spring numbers
    % to get the correct amount of intervals
    splitted_angle = linspace(voronoi_start_angle,voronoi_end_angle,vertex_spring_numbers(i)+1);
    
    % creating shape data and add them to the array
    shape.x = box_vertices_x(i);
    shape.y = box_vertices_y(i);
    for ii = 1:vertex_spring_numbers(i)
        shape.alpha1 = splitted_angle(i);
        shape.alpha2 = splitted_angle(i+1);
        shape.radius = spring_length;
        shape.isRect = false;
        box_springs= [boxsprings;{shape}];
    end
    
end

end

