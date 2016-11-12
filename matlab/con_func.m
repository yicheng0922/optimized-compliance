function [c ceq ] = con_func( x )

% the constraint function. 
% added 
% This constraint is statisfied if ceq = 0
% The function takes in a vector (x) that contains the displacement of the ends of all springs. 
% Based on the input, the function generates shape data for each spring. There
% are two types of shapes are generated, a box if the spring is lying on an
% edge, or a fan if the spring is lying on a vertex.
% The function perform SAT test to find out the MTLD between every single
% spring. The sum of the MTLD data will be returned as ceq.
% since there is no inequality constraint, c is returned as an empty vector.
% the order of the of the springs are springs from edge1 of polyhedron1, 
% springs from edge2 of polyhedron1, springs form vertex of polyhedron1,
% springs from polyhedron2  
% Note: Currently, the configuration of the bodies are hard coded.


SPRING_LENGTH = 4;

% the hard coded configuration starts here 
% a description of the configuration:
% the configuration is set up so that one vertex of polyhedron 1 is pointing toward 
% the edge of polyhedron 2. For simplicity reason, only the springs that are have a
% possibility of colliding are considered, which are the springs from the two edges 
% that form the vertex of polyhedron 1 and the edge from polyhedron2 that polyhedron 1
% is pointing to.
% spring number
% 
polyhedron1_edge1_spring_num = 10;
polyhedron1_edge2_spring_num = 10;
polyhedron1_vertex_spring_num = 3;
polyhedron2_edge_spring_num = 20;

% edge configuration
% each edge is represented by the initial vertex and the ending vertex
polyhedron1_edge1 = [10 0; 10 0];
polyhedron1_edge2 = [0 -10; 0 10];
polyhedron2_edge = [-15,15;-3,-3];

% orientation of the edges with respect to x axis
polyhedron1_edge1_alpha = calc_edge_orientation(polyhedron1_edge1);
polyhedron1_edge2_alpha = calc_edge_orientation(polyhedron1_edge2);
polyhedron2_edge_alpha = calc_edge_orientation(polyhedron2_edge);

% spring position calculation code starts here
% split the edge into intervals, each interval represents a spring
splitted_p1e1 = [linspace(polyhedron1_edge1(1,1), polyhedron1_edge1(1,2), polyhedron1_edge1_spring_num + 1); linspace(polyhedron1_edge1(2,1), polyhedron1_edge1(2,2), polyhedron1_edge1_spring_num + 1)];
splitted_p1e2 = [linspace(polyhedron1_edge2(1,1), polyhedron1_edge2(1,2), polyhedron1_edge2_spring_num + 1); linspace(polyhedron1_edge2(2,1), polyhedron1_edge2(2,2), polyhedron1_edge2_spring_num + 1)];
splitted_p2e = [linspace(polyhedron2_edge(1,1), polyhedron2_edge(1,2), polyhedron2_edge_spring_num + 1); linspace(polyhedron2_edge(2,1), polyhedron2_edge(2,2), polyhedron2_edge_spring_num + 1)];

% the voronoi region of the vertex is a fan shape bounded by the two normal of the edge that crosses the vertex
% an individual spring will be represented by a sector of the voronoi region
% to do that, the voronoi region is splitted into several smaller fan shapes

% split the angle into interval
% pi/2 are hard coded angle used to compute the angle of the normal
splitted_a = linspace(polyhedron1_edge1_alpha + pi/2, polyhedron1_edge2_alpha + pi/2, polyhedron1_vertex_spring_num + 1);

% start creating shapes for springs
% due to the fact that matlab requires struct in an array to have the same
% amount of fields, the vertex springs shape are put into a separated array
shapes_1e = [];
shapes_1v = [];

% an index used to indicate which spring its on.
index = 1;

% create shapes for edge1 springs
for (i = 1:polyhedron1_edge1_spring_num-1)
    shape = generate_box(x(index), SPRING_LENGTH, polyhedron1_edge1_alpha, splitted_p1e1(1,i), splitted_p1e1(2,i), splitted_p1e1(1,i+1), splitted_p1e1(1,i+1))
    shapes_1e = [shapes_1e;shape];
    index = index+1;
end

% create shapes for edge2 springs
for (i = 1:polyhedron1_edge2_spring_num)
    shape = generate_box(x(index), SPRING_LENGTH, polyhedron1_edge1_alpha, splitted_p1e2(1,i), splitted_p1e2(2,i), splitted_p1e2(1,i+1), splitted_p1e2(1,i+1))
    shapes_1e = [shapes_1e;shape];
    index = index+1;
end

% creates shapes for the vertex springs
clear shape;
% the vertex is always going to be [0 0]
shape.x=0; shape.y=0;
for (i = 1:polyhedron1_vertex_spring_num-1)
    shape.alpha1 = splitted_a(i);
    shape.alpha2 = splitted_a(i+1);
    shape.radius = SPRING_LENGTH + x(index);
    shape.isRect = false;
    index = index+1;
    shapes_1v = [shapes_1v;shape];
end

clear shape;
size_s1e = size(shapes_1e);
size_s1v = size(shapes_1v);

% we now create the shapes for the springs for the second polyhedron.
% the shape is then used to do SAT with all the shapes from polyhedron1 to find out the amount of intersection
sum = 0;
for (i = 1:polyhedron2_edge_spring_num-1)
    
    %creating shape
    shape = generate_box(x(index), SPRING_LENGTH, polyhedron1_edge1_alpha, splitted_p2e(1,i), splitted_p2e(2,i), splitted_p2e(1,i+1), splitted_p2e(1,i+1))
    
    %after creation of the shape, we try to find the overlap between 
    %the spring with the springs from polyhedra 1
    for j = 1:size_s1e(1)
        sum = sum + SAT(shapes_1e(j),shape);
    end
    for j = 1:size_s1v(1)
        sum = sum + SAT(shapes_1v(j),shape);
    end
end

%printing out the sum just for checking.
%sum
ceq = sum;
c=[];

end

