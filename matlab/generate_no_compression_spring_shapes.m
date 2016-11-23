function box_springs = generate_no_compression_spring_shapes( box_vertices_x, box_vertices_y , edge_spring_numbers, vertex_spring_numbers, spring_length)
%   This generates the shape information for the springs when there is no
%   compression.
%   
%   This function is supposed to generate the configurations 
%   that are not changing throughout the entire optimization process. 
%   The optimization program first create the springs given the 
%   polygon information and the spring length with this function.
%   Then in the constraint function, the compression on every spring will 
%   be pssed in and applied to the spring data. The modified data will be 
%   then used for SAT tests.
%
%   The function takes the following inputs:
%       box_vertices_x: A 1*4 array where every element is the x coordinate of
%                      a vertex from the box. The vertices should be in ccw order
%       box_vertices_y: A 1*4 array where every element is the y coordinate of
%                      a vertex from the box. The vertices should be in ccw order
%       edge_spring_numbers: A 1*4 array that holds how many springs should
%                           be on every edge
%       vertex_spring_numbers: A 1*4 array that holds how many springs
%                              should be on every vertex
%       spring_length: scalar representing the length of all springs

vertex_num = size(box_vertices_x,2);
box_springs = [];
edge_alphas = [];

% create edge springs
for i = 1:vertex_num
    
    % we find an edge by picking two consecutive vertices.   
    % find the next index
    next_i = i+1;
    if(next_i > vertex_num)
    % if i is the last index, the next index should be
    % the 1
        next_i = 1; 
    end
    
    cur_edge_x = box_vertices_x(i, next_i);
    cur_edge_y = box_vertices_y(i, next_i);
    
    % calculate orientation of the edge with respect to x axis
    edge_alpha = calc_edge_orientation(cur_edge_x, cur_edge_y);
    edge_alphas = [edge_alphas, edge_alpha];

    % split the edge into intervals, every interval represents a spring.
    
    % linspace is used to generate a vector of equally spaced points
    % between the first and the second vertex of the current edge. The
    % intervals between two consecutive points represent the springs.
    % Because there will be n-1 intervals between n points, we need to
    % generate one extra point than the number of springs we want the edge
    % to have so that we get the correct number of intervals.
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
    % because the order we generated the edges, the starting angle and ending angle
    % of the i-th vertex is edge_alpha(i-1) and edge_alpha(i) respectively.
    
    % find the starting index
    start_i = i-1;
    if(start_i == 0)
        % if i is 1, the starting index should be last vertex
        start_i = vertex_num;
    end
    
    % the modulus operator is used to wrap the angle to [0,2pi)
    voronoi_start_angle = mod(edge_alpha(start_i)+pi/2,2*pi);
    voronoi_end_angle = mod(edge_alpha(i)+pi/2,2*pi);
    
    % split the angle into intervals, each interval represents a vertex
    % spring.
    % same as the edge splitting, we need to add one to the spring numbers
    % to get the correct amount of intervals
    splitted_angle = linspace(voronoi_start_angle,voronoi_end_angle,vertex_spring_numbers(i)+1);
    
    % create shape data and add them to the array
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

