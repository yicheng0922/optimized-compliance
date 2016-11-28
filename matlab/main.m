% The main script
% -- Run this to start the optimized compliance example

% The X values are the amount of shape change that happens. A positive X
% element will mean extension and a negative one will mean compression.
options = optimoptions('fmincon','MaxFunEvals',50000, 'Display','iter');

% generate the polygon and the uncompressed spring shape data
box1_vertices_x = [0,0,1,1];
box1_vertices_y = [0,1,1,0];
box1_spring_length = 3;
box1_edge_spring_num = [5,5,5,5];
box1_vertex_spring_num = [5,5,5,5];
box1_spring = generate_no_compression_spring_shapes( box1_vertices_x, box1_vertices_y, box1_edge_spring_num, box1_vertex_spring_num, box1_spring_length);

box2_vertices_x = [4,4,5,5];
box2_vertices_y = [0,1,1,0];
box2_spring_length = 3;
box2_edge_spring_num = [5,5,5,5];
box2_vertex_spring_num = [5,5,5,5];
box2_spring = generate_no_compression_spring_shapes( box2_vertices_x, box2_vertices_y, box2_edge_spring_num, box2_vertex_spring_num, box2_spring_length);

box1_spring_num = sum(box1_edge_spring_num)+sum(box1_vertex_spring_num);
box2_spring_num = sum(box2_edge_spring_num)+sum(box2_vertex_spring_num);
total_spring_num = box1_spring_num + box2_spring_num;
k1 = 10;
k2 = 5;

% setup the objective and constraint functions
ofn = @(x) obj_func(x, box1_spring_num, box2_spring_num, k1, k2);
cfn = @(x) con_func(x, box1_spring, box2_spring);

% compute the spring lengths (for 80 springs in the example)
X = fmincon(ofn, zeros(total_spring_num,1),[],[],[],[],[],[],cfn,options);
    
