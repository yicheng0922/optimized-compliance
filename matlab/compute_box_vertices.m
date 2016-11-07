function vertices_world = compute_box_vertices( box )
%COMPUTE_BOX_VERTICES Summary of this function goes here
%   Detailed explanation goes here

    % calculate vertex
    x = box.x;
    y = box.y;
    w = box.w;
    h = box.h;
    alpha = box.alpha;
    
    % setting up box vertices
    vertices_x_box =[0.5*w 0.5*w -0.5*w -0.5*w];
    vertices_y_box =[0.5*h -0.5*h -0.5*h 0.5*h]; 

    % transforming vertices into world frame
    % rotate the vertices by alpha
    vertices_box = [vertices_x_box; vertices_y_box];
    vertices_world =[cos(alpha) -sin(alpha);sin(alpha) cos(alpha)] * vertices_box;
    % shift the vertices by (x,y)
    vertices_world(1,:)= vertices_world(1,:)+x;
    vertices_world(2,:)= vertices_world(2,:)+y;


end

