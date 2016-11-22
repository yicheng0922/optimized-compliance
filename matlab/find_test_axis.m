function testEdges = find_test_axis( shape )

% this function finds the axis that needs to be used for the SAT test based on shape data
% if the shape is a box (shape.isRect == true), this will return the direction vectors of the axis that are perpendicular to the edges.
% if the shape is a fan (shape.isRect == false), this will return the direction vectors of the axis that are perpendicular to two straight edges of the fan.


 if(shape.isRect == true)
        
        % the shape is a box
        % create rotation matrix
        R = [cos(shape.alpha) -sin(shape.alpha);sin(shape.alpha) cos(shape.alpha)];
        
        % find the axis where the first edge (the height) is on
        edge = R*[0; shape.h];
        
        % find direction vector of the axis that is perpendicular to the
        % axis we just found
        edge = [-edge(2),edge(1)];
        edge = edge/norm(edge);
        
        % add to the array
        testEdges = [testEdges;edge];

        % repeat the process with the second edge (the width)
        edge = R*[shape.w; 0];

        edge = [-edge(2),edge(1)];
        edge = edge/norm(edge);
        testEdges = [testEdges;edge];
 else
        
        % the shape is a fan
        radius = shape.radius;
        
        % find the axis where the first edge (the initial edge) is on
        edge = radius * [cos(shape.alpha1), sin(shape.alpha1)];
        
        % find direction vector of the axis that is perpendicular to the
        % axis we just found
        edge = [-edge(2),edge(1)];
        edge = edge/norm(edge);
        
        % add to the array
        testEdges = [testEdges;edge];
        
        %  repeat the process with the second edge (the ending edge)
        edge = shape.radius * [cos(shape.alpha2), sin(shape.alpha2)];
        edge = [-edge(2),edge(1)];
        edge = edge/norm(edge);
        testEdges = [testEdges;edge];
 end
end