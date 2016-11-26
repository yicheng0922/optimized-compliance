% a constraint test where all springs are compressed by one (displacement
% of the spring end is -2)
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

total_spring_num = sum(box1_edge_spring_num)+sum(box2_edge_spring_num)+sum(box1_vertex_spring_num)+sum(box2_vertex_spring_num);

X = ones(total_spring_num,1)*-2;
[c ceq] = con_func(X,box1_spring,box2_spring);

% the distance between the two boxes is 3. When the springs are
% compressed by 2, the spring length of each box will be 1 which will make
% sure there will be no  springs will interpenetrate, the constraint 
% function should return 0.
assert(ceq==0);
