function [c ceq ] = con_func( x )

%the constraint function
%take care of generating the shape for the springs (boxes for the ones on
%edges and sectors for the ones on vertices.
SPRING_LENGTH = 4;

% defining spring number, the total number of spring is this number-1
% because we are using linespace here
s1_edge1_spring = 11;
s1_edge2_spring = 11;
s2_edge1_spring = 21;
s1_vertex_spring = 4;
edge1 = [0 10;0 10];
edge2 = [0 -10;0 10];

%the angle the edges are facing
edge1_a = 7*pi/4;
edge2_a = 5*pi/4;
edge3 = [-15,15;-3,-3];
edge3_a = pi/2;

% Splitting the edge for generating position of the springs
splited_e1 = [linspace(edge1(1,1),edge1(1,2),s1_edge1_spring); linspace(edge1(2,1),edge1(2,2),s1_edge1_spring)];
splited_e2 = [linspace(edge2(1,1),edge2(1,2),s1_edge2_spring); linspace(edge2(2,1),edge2(2,2),s1_edge2_spring)];
splited_e3 = [linspace(edge3(1,1),edge3(1,2),s2_edge1_spring); linspace(edge3(2,1),edge3(2,2),s2_edge1_spring)];
splitted_a = linspace(edge1_a,edge2_a,s1_vertex_spring);

%start creating shapes for springs
%due to the fact that matlab requires struct in an array to have the same
%amount of fields, the vertex springs shape are put into a separated array
shapes_1e = [];
shapes_1v = [];
%shapes_2 = [];
index = 1;

% creating shapes for edge1 springs
for (i = 1:s1_edge1_spring-1)
    shape.x = splited_e1(1,i);
    shape.y = splited_e1(2,i);
    shape.w = 2^.5;
    shape.h = SPRING_LENGTH;
    shape.d = x(index);
    shape.alpha = edge1_a;
    index = index+1;
    shape.isRect = true;
    shapes_1e = [shapes_1e;shape];
end

%shapes for edge2 springs
for (i = 2:s1_edge2_spring)
    shape.x = splited_e2(1,i);
    shape.y = splited_e2(2,i);
    shape.w = 2^.5;
    shape.h = SPRING_LENGTH;
    shape.d = x(index);
    shape.alpha = edge2_a;
    index = index+1;
    shape.isRect = true;
    shapes_1e = [shapes_1e;shape];
end

%shapes for the vertex springs
clear shape;
shape.x=0; shape.y=0;
for (i = 1:s1_vertex_spring-1)
    shape.alpha1 = splitted_a(i);
    shape.alpha2 = splitted_a(i+1);
    shape.radius = SPRING_LENGTH;
    shape.isRect = false;
    shape.d = x(index);
    index = index+1;
    shapes_1v = [shapes_1v;shape];
end

clear shape;
size_s1e = size(shapes_1e);
size_s1v = size(shapes_1v);

%we now create the springs for the second polyhedra. In this example, only
%a edge is used for simlicity reason.
sum = 0;
for (i = 1:s2_edge1_spring-1)
    
    %creating shape
    shape.x = splited_e3(1,i);
    shape.y = splited_e3(2,i);
    shape.w = 1.5;
    shape.h = SPRING_LENGTH;
    shape.d = x(index);
    index = index+1;
    shape.isRect = true;
    shape.alpha = edge3_a;
    
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
sum
ceq = sum;
c=[];

end

