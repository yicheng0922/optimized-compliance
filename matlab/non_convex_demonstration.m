% this program demonstrates the fact that the result produced by the optimal
% set algorithm is not the optimal configuration which may imply the non-convextivity
% of the optimization problem.


% generate spring data
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

% this is the configuration that active set said as optimal and feasible
% this is not optimal becasue the springs that are not in contact are also compressed
X = ones(80,1)*-1.5;
obj = obj_func(X, box1_spring_num, box2_spring_num, k1, k2);
[c ceq] = con_func(X, box1_spring, box2_spring);

% manually modify the configuration, so that some of the springs that are not in contact
% are no longer compressed
X_modified = X;
X_modified(1:5) = X_modified(1:5)+1.5;
obj_mod = obj_func(X_modified, box1_spring_num, box2_spring_num, k1, k2);
[c_mod ceq_mod] = con_func(X_modified, box1_spring, box2_spring);


% ceq is the constraint vaule and obj is the objective value
% variable with the "_mod" postfix are values for the modified
% configuration
ceq
obj
ceq_mod
obj_mod

