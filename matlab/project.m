function [ min_dot, max_dot ] = project( shape, axis )
% This function projects 'shape' onto the given axis.
% When shape is a box (isRect = true), all four vertices will be 
% projected. 
% when shape is a sector (isRect = false), the center, the end points of
% the arc, and the intersection of the line through the center and parallel
% to the axis will be projected onto the axis

% The array that contains the vertices to be projected
vertices_world =[];

% compute vertices that are going to be projected
% Rectangle
if(shape.isRect == true)
    vertices_world = compute_box_vertices(shape);
else
    % getting information
    x = shape.x;
    y = shape.y;
    radius = shape.radius;
    alpha1 = shape.alpha1;
    alpha2 = shape.alpha2;
    
    % the center, and the two arc end
    vertices_world = [x, x+radius*cos(alpha1), x+radius*cos(alpha2); y, y+radius*sin(alpha1), y+radius*sin(alpha2)];
    
    % check if the line parallel to axis and crosses the center intersescts
    % the arc, if true, the intersection need to be added. This is done by
    % checking if the axis is pointing to a direction between alpha1 and
    % alpha2
    axis_angle = atan(axis(2)/axis(1));
    
    % This is used to make sure that angle is within [0,2pi)
    if(axis_angle < 0)
        axis_angle = axis_angle + 2*pi;
    end
    
    
    % the product will return negative if axis_angle is between alpha1 and
    % alpha2
    if((alpha1-axis_angle)*(alpha2-axis_angle)<0)
       vertices_world(:,4)=[x+radius*cos(axis_angle); y+radius*sin(axis_angle)];
    end
    
    % Since the back of the line also need to be checked, the oppoisite
    % direction is checked
    axis_angle = axis_angle - pi;
    if(axis_angle < 0)
        axis_angle = axis_angle + 2*pi;
    end
    if((alpha1-axis_angle)*(alpha2-axis_angle)<0)
       vertices_world(:,4)=[x+radius*cos(axis_angle); y+radius*sin(axis_angle)];
    end
    
end

% project by doing dot product and finding the minimum and maximum.
min_dot = realmax;
max_dot = -realmax;
[vertex_num, dim] = size(vertices_world);
for i = 1:vertex_num
    value = axis*vertices_world(:,i);
    if(value < min_dot)
      min_dot = value;
    end
    if(value > max_dot)
      max_dot = value;  
    end
end

