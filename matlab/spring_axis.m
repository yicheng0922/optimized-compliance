function axis = spring_axis( spring )
% this function returns the direction vector of the spring
% this function take the shape data of the spring and return the direction
% vector of the height if the spring is a box and the direction of the
% vector connecting the midpoint of the arc and the center if the spring is
% a fan


if(spring.isRect)
    % the shape is a box
    % create rotation matrix
    R = [cos(shape.alpha) -sin(shape.alpha);sin(shape.alpha) cos(shape.alpha)];
    
    % find the axis where the first edge (the height) is on
    axis = (R*[0; 1])';
    
else
    % the shape is a fan    
    % find the axis where the vector connecting the midpoint of the arc and
    % the center is on
    midpoint_alpha = (shape.alpha1+shape.alpha2)/2;
    axis = 1 * [cos(midpoint_alpha), sin(midpoint_alpha)];
end



end

