function vertices_world = compute_box_vertices( box )
% compute the coordinates of a given box
% input:
%   box: The shape data of the box. Contains following members:
%           x: the x coordinate of the center of the box
%           y: the y coordinate of the center of the box
%           w: the width of the box
%           h: the height of the box 
%           alpha: the 2d orientation of the box represented by an angle in 
%                   radians, measured counterclockwise from the x-axis 

    % calculate vertex
    x = box.x;
    y = box.y;
    w = box.w;
    h = box.h;
    alpha = box.alpha;
    
    % set up box vertices
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

