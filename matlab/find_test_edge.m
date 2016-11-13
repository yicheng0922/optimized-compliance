function testEdges = find_test_axis( shape )

% this function finds the axis that needs to be used for the SAT test based on shape data
% if the shape is a box (shape.isRect == true), this will return the direction vectors of the edges.
% if the shape is a fan (shape.isRect == false), this will return the direction vectors of the two straight edge of the fan.


 if(shape.isRect == true)
        
        %box
        %create rotation matrix
        R = [cos(shape.alpha) -sin(shape.alpha);sin(shape.alpha) cos(shape.alpha)];
        
        %the first edge
        edge = R*[0; shape.h];
        edge = [-edge(2),edge(1)];
        edge = edge/norm(edge);
        testEdges = [testEdges;edge];

        %the second edge
        edge = R*[shape.w; 0];
        edge = [-edge(2),edge(1)];
        edge = edge/norm(edge);
        testEdges = [testEdges;edge];
    else
        %sector of circle

        %find the radius, perhaps not needed?
        radius = shape.radius;
        
        %edge1
        edge = radius * [cos(shape.alpha1), sin(shape.alpha1)];
        edge = [-edge(2),edge(1)];
        edge = edge/norm(edge);
        testEdges = [testEdges;edge];
        
        %edge 2
        edge = shape.radius * [cos(shape.alpha2), sin(shape.alpha2)];
        edge = [-edge(2),edge(1)];
        edge = edge/norm(edge);
        testEdges = [testEdges;edge];
    end