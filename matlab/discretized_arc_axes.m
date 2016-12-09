function arc_axis = discretized_arc_axes( fan, axis_number )
    % this function generates the testing axis by discretizing the arc of
    % the fan and find the normal of every segment.
    % fan will be the shape data of the fan shape, and axis_number will be
    % the number of axis that want to be generated.
    
    start_angle = fan.alpha1;
    end_angle = fan.alpha2;
    
    % split the angle into smaller angles
    splitted_angle = linspace(start_angle, end_angle, axis_number+1);
    
    % discretize the arc into multiple points
    splitted_x = fan.radius*cos(splitted_angle);
    splitted_y = fan.radius*sin(splitted_angle);
    
    % calculate the difference between consecutive points
    y_difference = splitted_y(2:axis_number+1) - splitted_y(1:axis_number);
    x_difference = splitted_x(2:axis_number+1) - spliited_x(1:axis_number);
    
    
    
    % the normal will be negative reciprocal of the original vector
    arc_axis = [-y_difference; x_difference]';
    
    % normalize the axis
    for i = 1:number_axis
        arc_axis(:,i) = arc_axis(:,i)/norm(arc_axis(:,i));
    end

end